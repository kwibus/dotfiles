vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*/grammar.js"},
  command =  "LspStop"
})

vim.api.nvim_create_user_command('PrintProjectRoot', function()
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
  end
    print(client.name .. ": " .. (client.config.root_dir or "no root"))
end, {})


function scroll_view(event)
  for _, client in ipairs(vim.lsp.get_clients()) do
      if client.name == "esbonio" then
          local view = vim.fn.winsaveview()

          local params = { uri = vim.uri_from_bufnr(0),  line = view.topline }
          client.notify('view/scroll', params)
        end
  end
end
function preview_file()
    local params = {
        command = 'esbonio.server.previewFile',
        arguments = {
            { uri = vim.uri_from_bufnr(0) },
        },
    }

    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
        client.request('workspace/executeCommand', params, nil, 0)
    end

    local augroup = vim.api.nvim_create_augroup("EsbonioSyncScroll", { clear = true })
    vim.api.nvim_create_autocmd({"WinScrolled"}, {
        callback = scroll_view, group = augroup, buffer = 0
    })
end
return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cond = function ()
          return not vim.g.vscode
        end, -- don`t run in vscode
        config = function()

            -- vim.lsp.set_log_level('debug')

            local get_git_root = function(fname)
                local path = vim.fn.expand( '%:p:h')
                local root = vim.fn.systemlist("git -C " .. path .." rev-parse --show-superproject-working-tree")[1]
                return root
            end
            local add_git_parent_detection  = function(lsp_id)
                local get_root = function(fname)
                    local git_parent_root = get_git_root(fname)
                    if git_parent_root == '' then
                        return require("lspconfig.configs." .. lsp_id).default_config.get_root
                    end
                    return git_parent_root
                end
                return get_root
            end
            local lspconfig = require("lspconfig")
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
            capabilities.workspace = { didChangeWatchedFiles = { dynamicRegistration = true } }
            -- Add blink.cmp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                capabilities
            )
            vim.lsp.enable("clangd")
            vim.lsp.config('lua_ls',{
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            -- Makes it slow
                            -- library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,

                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            })
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("intelephense")
            -- lspconfig.phpcs.setup {}
                -- root_dir = function ()
                --     return vim.loop.cwd()
                -- end,
            vim.lsp.enable("marksman")
            vim.lsp.enable('systemd_ls')
            vim.lsp.enable("ansiblels")
            vim.lsp.enable("bashls")
            vim.lsp.enable("vimls")
            vim.lsp.enable("rust_analyzer")

            vim.lsp.config("esbonio",{
                cmd = {'esbonio'},
                filetypes = { 'rst' }, -- or 'markdown' if you use MyST
                root_markers = { '.git' },
                settings = {
                    esbonio = {
                        sphinx = {
                            buildCommand = {'sphinx-build', '-M', 'dirhtml', '.', '${defaultBuildDir}'},
                            pythonCommand = {'/home/rens/.local/share/uv/tools/esbonio/bin/python'},
                        }
                    },
                },
            })
            vim.lsp.enable("esbonio")
            -- {
            --     cmd = { 'esbonio' },
            --     init_options = {
            --         server = {
            --             logLevel = "debug",
            --             enableLivePreview = true,
            --             python_command = {"/bin/python3"},
            --             preview = {
            --                 port = 12345
            --             }
            --         },
            --         sphinx = {
            --             builderName = "html",
            --             enableDevTools = false,
            --             -- confDir = "/path/to/docs",
            --             -- srcDir = "${confDir}/../docs-src"
            --         }
            --     },
            --     root_dir = add_git_parent_detection('esbonio'),
            --     commands = {
            --         EsbonioPreviewFile = {
            --             preview_file,
            --             description = 'Preview Current File',
            --         },
            --     }
            -- })

            -- vim.lsp.enable('codebook')
            -- FIXME: re enable
            --     -- filetypes = {"markdown"}, -- to much false positive for now
            -- lspconfig.harper_ls.setup {
            --     capabilities = capabilities,
            --     settings = {
            --         ["harper-ls"] = {
            --             linters = {
            --                 SentenceCapitalization = false,
            --                 SpellCheck = false,
            --                 ToDoHyphen = false,
            --                 Spaces = false,
            --                 LongSentences = false,
            --             }
            --         }
            --     }
            -- }
            vim.lsp.enable({ "ts_ls", }) -- "eslint" "ts_lint",
            vim.lsp.enable("jsonls")
            vim.lsp.enable("yamlls")
            vim.lsp.enable({'pyright', 'pyrefly', 'ruff'})
        end
    },
    {
        'b0o/schemastore.nvim',
        ft = {"json", "yaml", "helm"},
        lazy = true,
        config = function ()
            vim.lsp.config("jsonls", {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.config("yamlls",{
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = require('schemastore').yaml.schemas {
                            ignore = {
                                'prometheus.rules.test.json',
                            }
                        },
                    },
                }
            })
        end
    }
}
