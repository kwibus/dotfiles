return {
    'gbprod/yanky.nvim',
    dependencies = {
        { "kkharji/sqlite.lua" }
    },
    opts = {
        ring = {
            storage = "sqlite"
        },
        highlight = {
            on_put = true,
            on_yank = true,
            timer = 500,
        },
    },
    keys = {
        {"y"}, -- lazy plugin on yank
        {"<a-p>", "<Plug>(YankyPreviousEntry)"},
        {"<a-n>", "<Plug>(YankyNextEntry)"},
        {"p", "<Plug>(YankyPutAfter)"},
        {"P", "<Plug>(YankyPutBefore)"},
        -- {"gp", "<Plug>(YankyGPutAfter)"}, -- conflicts code companion
        -- {"gP", "Plug>(YankyGPutBefore)"},
    }
}
