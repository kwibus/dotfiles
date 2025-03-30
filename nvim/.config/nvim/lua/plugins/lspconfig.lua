return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        -- cond = function() // TODO condition load
        --     return package.loaded['cmp-nvim-lsp']
        -- end,
        dependencies = {
            "b0o/schemastore.nvim", -- json schemas
            'saghen/blink.cmp',
            -- "hrsh7th/nvim-cmp"
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspconfig.pyright.setup({capabilities = capabilities})
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
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
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,

                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            })
            -- lspconfig.phpcs.setup {}
            lspconfig.intelephense.setup({
                capabilities = capabilities,
                -- root_dir = function ()
                --     return vim.loop.cwd()
                -- end,
            })
            lspconfig.systemd_ls.setup({ capabilities = capabilities, })
            lspconfig.ansiblels.setup({capabilities = capabilities, })
            lspconfig.bashls.setup({ capabilities = capabilities, })
            lspconfig.vimls.setup({ capabilities = capabilities, })
            lspconfig.ts_ls.setup({ capabilities = capabilities, })
            lspconfig.rust_analyzer.setup({ capabilities = capabilities, })
            lspconfig.harper_ls.setup {
                -- filetypes = {"markdown"}, -- to much false positive for now
                capabilities = capabilities,
                settings = {
                    ["harper-ls"] = {
                        linters = {
                            SentenceCapitalization = false,
                            SpellCheck = false,
                            ToDoHyphen = false,
                            Spaces = false,
                            LongSentences = false,
                        }
                    }
                }
            }
            lspconfig.yamlls.setup({
                capabilities = capabilities,
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
            lspconfig.jsonls.setup {
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            }
        end,
    }
}
