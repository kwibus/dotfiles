vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*/grammar.js"},
  command =  "LspStop"
})

vim.api.nvim_create_user_command('PrintProjectRoot', function()
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
    print(client.name .. ": " .. (client.config.root_dir or "no root"))
  end
end, {})

-- NOTE: esbonio (Sphinx/reStructuredText LSP) is configured in ftplugin/rst.lua
return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        -- enabled = false,
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
            local ok, blink = pcall(require, 'blink.cmp' )
            local capabilities = {}
            if ok then
                capabilities = blink.get_lsp_capabilities()
            end

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
            vim.lsp.enable('lua_ls')
            -- vim.lsp.config('lua_ls',{
            --     settings = {
            --         Lua = {
            --             runtime = {
            --                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            --                 version = "LuaJIT",
            --             },
            --             diagnostics = {
            --                 -- Get the language server to recognize the `vim` global
            --                 globals = { 'vim' },
            --             },
            --             workspace = {
            --                 -- Make the server aware of Neovim runtime files
            --                 -- Makes it slow
            --                 -- library = vim.api.nvim_get_runtime_file("", true),
            --                 checkThirdParty = false,
            --
            --             },
            --             -- Do not send telemetry data containing a randomized but unique identifier
            --             telemetry = {
            --                 enable = false,
            --             },
            --         }
            --     }
            -- })
            -- vim.lsp.enable("lua_ls")
            vim.lsp.config("intelephense",{
                settings = {
                    intelephense = {
                        environment = {
                            -- Replace this with the actual path to your Moodle root
                            includePaths = {"/home/rens/werk/lab-tools/moodle-dev/moodle_data"}
                        },
                        files = {
                            maxSize = 5000000; -- Moodle is huge, sometimes you need to bump this
                        }
                    }
                }
            })
            vim.lsp.enable("intelephense")
            -- lspconfig.phpcs.setup {}
                -- root_dir = function ()
                --     return vim.loop.cwd()
                -- end,

            vim.lsp.config("ltex_plus", {
                settings ={
                    ltex = {
                        language = "auto",
                        -- completionEnabled = true,
                        -- additionalRules = {
                        --     motherTongue = "nl",
                        -- },
                        dictionary = {
                            -- Pass the list of words to the LSP
                            ["en-US"] = ":" .. vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
                            ["nl"]    = ":" .. vim.fn.stdpath("config") .. "/spell/nl.utf-8.add",
                        },
                    },
                }
            })
            vim.lsp.enable("ltex_plus")
            vim.lsp.enable("marksman")
            vim.lsp.enable('systemd_lsp')
            vim.lsp.enable("ansiblels")
            vim.lsp.enable("bashls")
            vim.lsp.enable("vimls")
            -- vim.lsp.enable("rust_analyzer") -- replaced by rustaceanvim
            vim.lsp.enable('gopls')
            -- esbonio (rst) is configured in ftplugin/rst.lua

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
            vim.lsp.enable("hls")
            vim.lsp.enable("jsonls")
            vim.lsp.enable("yamlls")
            vim.lsp.enable({
                -- 'pyright',
                'ty',
                'pyrefly',
                'ruff'
            })
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
