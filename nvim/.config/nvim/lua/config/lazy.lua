-- Bootstrap lazy.nvim

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.pack.add({ "https://github.com/folke/lazy.nvim" }, { branch = "main", load = false })
vim.cmd.packadd("lazy.nvim")
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--     local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--     local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
--     if vim.v.shell_error ~= 0 then
--         vim.api.nvim_echo({
--             { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
--             { out,                            "WarningMsg" },
--             { "\nPress any key to exit..." },
--         }, true, {})
--         vim.fn.getchar()
--         os.exit(1)
--     end
-- end
-- vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    defaults = {
        lazy = true,
    },
    performance = {
        -- rtp = {}
    },
    change_detection = {
        enabled = true,
        notify = true,
    },

    install = { colorscheme = { "NeoSolarized" } },
    checker = { enabled = false },
    ui = {
        -- make full size, don't like floating, inside vim
        -- size =  {width = 01, height = 1 },
        title = "Lazy",
        border = 'single'
    },
    rocks = {
        enabled = false,
    }
})
