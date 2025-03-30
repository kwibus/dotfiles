return {
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = "Telescope",
        keys = {
            {"<F12>", "<cmd>Telescope find_files<cr>"},
        }
    -- },{
    --     -- I don't really use this plugin, don't know sure if its setup correctly
    --     'nvim-telescope/telescope-dap.nvim',
    --
    --     -- cond = vim.tbl_get(require("lazy.core.config"), "plugins", "dap", "_", "loaded"),
    --     dependencies = { 'nvim-telescope/telescope.nvim' },
    --     init = function  ()
    --         require('telescope').load_extension('dap')
    --     end,
    --
    }
}
