return {
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'linrongbin16/lsp-progress.nvim',
        },
        opts = {
            theme = 'auto',
            extensions = { 'quickfix', 'lazy', 'trouble', 'nvim-dap-ui' },
            options = {
                -- TODO does not seem to work
                -- disabled_buftypes = { 'quickfix', 'prompt' }, -- Hide a window if its buffer's type is disabled
                icons_enabled = true,
            },
            sections = {
                lualine_a = { 'mode', },
                lualine_b = { 'branch', 'diff', },
                lualine_c = { 'filename',
                    function()
                        return require('lsp-progress').progress()
                    end,
                    -- function()
                    --     local trouble = require("trouble")
                    --     local symbols = trouble.statusline({
                    --         mode = "lsp_document_symbols",
                    --         groups = {},
                    --         title = false,
                    --         filter = { range = true },
                    --         format = "{kind_icon}{symbol.name:Normal}",
                    --         -- The following line is needed to fix the background color
                    --         -- Set it to the lualine section you want to use
                    --         hl_group = "lualine_c_normal",
                    --     })
                    --
                    --     return symbols.get()
                    -- end,
                },
                lualine_x = { 'searchcount', 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'diagnostics', 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    'filename',
                },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
        }
    }, {
    {
        'linrongbin16/lsp-progress.nvim',
        config = function()
            require('lsp-progress').setup({})
        end
    }
}
}
