return {
    'numToStr/Navigator.nvim',
    cond =  vim.env.TMUX ~= nil,
    cmd = {
        'NavigatorLeft',
        'NavigatorRight',
        'NavigatorUp',
        'NavigatorDown',
        'NavigatorPrevious'
    },
    keys = {
        { mode = {'n', 't'}, '<c-h>', '<CMD>NavigatorLeft<CR>'},
        { mode = {'n', 't'}, '<c-l>', '<CMD>NavigatorRight<CR>'},
        { mode = {'n', 't'}, '<c-k>', '<CMD>NavigatorUp<CR>'},
        { mode = {'n', 't'}, '<c-j>', '<CMD>NavigatorDown<CR>'},
        { mode = {'n', 't'}, '<c-p>', '<CMD>NavigatorPrevious<CR>'}
    },
    config = function()
        require('Navigator').setup()
    end,
    -- "christoomey/vim-tmux-navigator",
    -- cond =  vim.env.TMUX ~= nil,
    -- cmd = {
    --     "TmuxNavigateLeft",
    --     "TmuxNavigateDown",
    --     "TmuxNavigateUp",
    --     "TmuxNavigateRight",
    --     "TmuxNavigatePrevious",
    --     "TmuxNavigatorProcessList",
    -- },
    -- keys = {
    --     { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    --     { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    --     { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    --     { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    --     { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    -- },
}
