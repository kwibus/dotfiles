return {
    { 
        "Tsuzat/NeoSolarized.nvim",
        -- enabled = false,
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function(_, opts)
            require('NeoSolarized').setup(opts)
            vim.cmd.colorscheme('NeoSolarized')
        end,
        opts = {
            style = "dark", -- "dark" or "light"
            transparent = true, -- true/false; Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
            enable_italics = true, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
            styles = {
                -- Style to be applied to different syntax groups
                comments = { italic = false},
                keywords = { italic = false},
                functions = { bold = true },
                variables = {},
                string = { italic = true },
                underline = true , -- true/false; for global underline
                undercurl = true, -- true/false; for global undercurl
            },
            on_highlights = function(highlights, colors)
                -- give FoldColumn more contrast
                highlights.FoldColumn.fg = colors.fg1
                -- this plugins overwrites MiniCursorword, that i don't like
                highlights.MiniCursorword.bg = colors.bg
                highlights.MiniCursorwordCurrent.bg = colors.bg
                highlights.MiniCursorword.underline= true
                highlights.MiniCursorwordCurrent.underline= true
            end,

        },
    },
    --,{
    --     'stevedylandev/ansi-nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd('colorscheme ansi')
    --         vim.opt.termguicolors = false
    --     end,
    -- }
    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     priority = 1000 ,
    --     config = true,
    --     opts = {
    --         transparent_mode = false
    --     }
    -- }
}
