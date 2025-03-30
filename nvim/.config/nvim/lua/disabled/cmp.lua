return {
    {
        'hrsh7th/nvim-cmp',
        lazy = true,
        enabled = false,
        -- priority = 100,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-omni',
            -- 'dmitmel/cmp-cmdline-history',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'onsails/lspkind.nvim',
            'tamago324/cmp-zsh',      -- TODO loads only if shell
            'andersevenrud/cmp-tmux', -- TODO loads only when in tmux
            'ray-x/cmp-treesitter',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            -- ai completion
            -- 'tzachar/cmp-ai', -- did not work well with ollama
            -- 'milanglacier/minuet-ai.nvim',
            'f3fora/cmp-spell',
            'supermaven-inc/supermaven-nvim',
            'dmitmel/cmp-digraphs'
        },
        event = "VeryLazy",
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            cmp.setup {
                performance = {
                    -- It is recommended to increase the timeout duration due to
                    -- the typically slower response speed of LLM's compared to
                    -- other completion sources. This is not needed when you only
                    -- need manual completion.
                    fetching_timeout = 2000,
                },
                snippet = {
                    -- expand = function(args)
                    --     -- old
                    --     -- luasnip.lsp_expand(args.body)
                    --     local suggestion = require('supermaven-nvim.completion_preview')
                    --     if luasnip.expandable() then
                    --         luasnip.expand()
                    --     elseif suggestion.has_suggestion() then
                    --         suggestion.on_accept_suggestion()
                    --     end
                    -- end,
                },

                formatting = {
                    -- format = function(entry, vim_item)
                    --     local highlights_info = require("colorful-menu").cmp_highlights(entry)
                    --
                    --     -- highlight_info is nil means we are missing the ts parser, it's
                    --     -- better to fallback to use default `vim_item.abbr`. What this plugin
                    --     -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                    --     if highlights_info ~= nil then
                    --         vim_item.abbr_hl_group = highlights_info.highlights
                    --         vim_item.abbr = highlights_info.text
                    --     end
                    --
                    --     return vim_item
                    -- end,
                    -- fields = { "kind", "abbr", "menu" },
                    --
                    -- format = function(entry, vim_item)
                    --     local kind = require("lspkind").cmp_format({
                    --         mode = "symbol_text",
                    --     })(entry, vim.deepcopy(vim_item))
                    --     local highlights_info = require("colorful-menu").cmp_highlights(entry)
                    --
                    --     -- highlight_info is nil means we are missing the ts parser, it's
                    --     -- better to fallback to use default `vim_item.abbr`. What this plugin
                    --     -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                    --     if highlights_info ~= nil then
                    --         vim_item.abbr_hl_group = highlights_info.highlights
                    --         vim_item.abbr = highlights_info.text
                    --     end
                    --     local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    --     vim_item.kind = " " .. (strings[1] or "") .. " "
                    --     vim_item.menu = ""
                    --
                    --     return vim_item
                    -- end,
                    format = require 'lspkind'.cmp_format {
                        mode = "symbol_text",
                        menu = {
                            nvim_lsp = "[LSP]",
                            omni = "[Omni]",
                            buffer = "[Buffer]",
                            -- path = "[Path]",
                            latex_symbols = "[Latex]",
                            luasnip = "[LuaSnip]",
                            cmdline_history = "[history]",
                            zsh = "[zsh]",
                            tmux = "[tmux]",
                            spell = "[spell]",
                            supermaven = "[suppermaven]",
                        }
                    }
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                view = {
                    entries = {
                        name = 'custom',
                        selection_order = 'near_cursor'
                    }
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-l>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    -- -- { name = 'cmp_ai' },
                    -- -- { name = 'minuet' },
                    {
                        name = 'omni',
                        option = {
                            disable_omnifuncs = { 'v:lua.vim.lsp.omnifunc' }
                        }
                    },
                    { name = "supermaven" },
                    { name = 'digraphs' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'calc' },
                    { name = 'path' },
                    { name = 'treesitter' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'zsh' },
                    { name = 'tmux',
                        option = {
                            -- Source from all panes in session instead of adjacent panes
                            all_panes = true,

                            -- Completion popup label
                            label = '[tmux]',

                            -- Trigger character
                            -- trigger_characters = { '.' },

                            -- Specify trigger characters for filetype(s)
                            -- { filetype = { '.' } }
                            -- trigger_characters_ft = {},

                            -- Keyword patch pattern
                            -- keyword_pattern = [[\w\+]],

                            -- Capture full pane history
                            -- `false`: show completion suggestion from text in the visible pane (default)
                            -- `true`: show completion suggestion from text starting from the beginning of the pane history.
                            --         This works by passing `-S -` flag to `tmux capture-pane` command. See `man tmux` for details.
                            capture_history = true,
                        },
                    }, {
                    name = "spell",
                    option = {
                        keep_all_entries = false,
                        enable_in_context = function()
                            return true
                        end,
                        preselect_correct_word = false,
                    },
                },
                })
            }
            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    {
                        name = 'path'
                    }
                }, {
                    {
                        name = 'cmdline_history',
                    },
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    },
                }
                )
            })
            -- `/` cmdline setup.
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
        end
    }, {
    'L3MON4D3/LuaSnip',
    lazy = false,
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    build = "make install_jsregexp",
    init = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}, {

    'andersevenrud/cmp-tmux',
    lazy = false,
    cond = vim.env.TMUX ~= nil,
}, {
    'tamago324/cmp-zsh',
    ft = { 'zsh', 'sh', 'bash' },

    lazy = false,
    opts = {
        filetypes = { "zsh", "sh", "bash", }
    },
}, {
    "supermaven-inc/supermaven-nvim",
    enabled = true,
    config = function()
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = "<C-l>",
                clear_suggestion = "<C-k>",
                accept_word = "<C-j>",
            },
            color = {
                suggestion_color = "#3f3f3f",
                cterm = 244,
            },
        })
    end,
    -- }, {
    --     "xzbdmw/colorful-menu.nvim",
    --     config = function()
    --         -- You don't need to set these options.
    --         require("colorful-menu").setup({
    --             ls = {
    --                 lua_ls = {
    --                     -- Maybe you want to dim arguments a bit.
    --                     arguments_hl = "@comment",
    --                 },
    --                 gopls = {
    --                     -- By default, we render variable/function's type in the right most side,
    --                     -- to make them not to crowd together with the original label.
    --
    --                     -- when true:
    --                     -- foo             *Foo
    --                     -- ast         "go/ast"
    --
    --                     -- when false:
    --                     -- foo *Foo
    --                     -- ast "go/ast"
    --                     align_type_to_right = true,
    --                     -- When true, label for field and variable will format like "foo: Foo"
    --                     -- instead of go's original syntax "foo Foo". If align_type_to_right is
    --                     -- true, this option has no effect.
    --                     add_colon_before_type = false,
    --                     -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
    --                     preserve_type_when_truncate = true,
    --                 },
    --                 -- for lsp_config or typescript-tools
    --                 ts_ls = {
    --                     -- false means do not include any extra info,
    --                     -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
    --                     extra_info_hl = "@comment",
    --                 },
    --                 vtsls = {
    --                     -- false means do not include any extra info,
    --                     -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
    --                     extra_info_hl = "@comment",
    --                 },
    --                 ["rust-analyzer"] = {
    --                     -- Such as (as Iterator), (use std::io).
    --                     extra_info_hl = "@comment",
    --                     -- Similar to the same setting of gopls.
    --                     align_type_to_right = true,
    --                     -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
    --                     preserve_type_when_truncate = true,
    --                 },
    --                 clangd = {
    --                     -- Such as "From <stdio.h>".
    --                     extra_info_hl = "@comment",
    --                     -- Similar to the same setting of gopls.
    --                     align_type_to_right = true,
    --                     -- the hl group of leading dot of "•std::filesystem::permissions(..)"
    --                     import_dot_hl = "@comment",
    --                     -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
    --                     preserve_type_when_truncate = true,
    --                 },
    --                 zls = {
    --                     -- Similar to the same setting of gopls.
    --                     align_type_to_right = true,
    --                 },
    --                 roslyn = {
    --                     extra_info_hl = "@comment",
    --                 },
    --                 dartls = {
    --                     extra_info_hl = "@comment",
    --                 },
    --                 -- The same applies to pyright/pylance
    --                 basedpyright = {
    --                     -- It is usually import path such as "os"
    --                     extra_info_hl = "@comment",
    --                 },
    --                 -- If true, try to highlight "not supported" languages.
    --                 fallback = true,
    --                 -- this will be applied to label description for unsupport languages
    --                 fallback_extra_info_hl = "@comment",
    --             },
    --             -- If the built-in logic fails to find a suitable highlight group for a label,
    --             -- this highlight is applied to the label.
    --             fallback_highlight = "@variable",
    --             -- If provided, the plugin truncates the final displayed text to
    --             -- this width (measured in display cells). Any highlights that extend
    --             -- beyond the truncation point are ignored. When set to a float
    --             -- between 0 and 1, it'll be treated as percentage of the width of
    --             -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
    --             -- Default 60.
    --             max_width = 60,
    --         })
    --     end,
}
    --     'tzachar/cmp-ai',
    --     dependencies = 'nvim-lua/plenary.nvim',
    --     opts = {
    --         max_lines = 100,
    --         provider = 'Ollama',
    --         provider_options = {
    --             model = 'codellama:7b-code',
    --             auto_unload = false, -- Set to true to automatically unload the model when
    --             -- exiting nvim.
    --         },
    --         notify = true,
    --         notify_callback = function(msg)
    --             vim.notify(msg)
    --         end,
    --         run_on_every_keystroke = true,
    --         ignored_file_types = {
    --             -- default is not to ignore
    --             -- uncomment to ignore in lua:
    --             -- lua = true
    --         },
    --     },
    -- }, {
    --     'milanglacier/minuet-ai.nvim',
    --     config = function()
    --         require('minuet').setup {
    --             provider = 'openai_fim_compatible',
    --             n_completions = 1, -- recommend for local model for resource saving
    --             -- I recommend beginning with a small context window size and incrementally
    --             -- expanding it, depending on your local computing power. A context window
    --             -- of 512, serves as an good starting point to estimate your computing
    --             -- power. Once you have a reliable estimate of your local computing power,
    --             -- you should adjust the context window to a larger value.
    --             context_window = 512,
    --             provider_options = {
    --                 openai_fim_compatible = {
    --                     api_key = 'TERM',
    --                     name = 'Ollama',
    --                     end_point = 'http://localhost:11434/v1/completions',
    --                     -- model = 'qwen2.5-coder:7b',
    --                     model = 'qwen2.5-coder',
    --                     optional = {
    --                         max_tokens = 56,
    --                         top_p = 0.9,
    --                     },
    --                 },
    --             }, }
    --     end,
    -- }
}
