-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	-- generate with
	-- :lua local f=io.open("full_plugin_list.lua", "w"); f:write("return {\n"); for _,p in pairs(require("lazy").plugins()) do f:write('  { "' .. p.url .. '" },\n') end; f:write("}") f:close(); print("List saved to full_plugin_list.lua")  -- add your plugins here
	spec = {
		{ "https://github.com/neovim/nvim-lspconfig.git" },
		{ "https://github.com/nono/lezer.vim.git" },
		{ "https://github.com/wgwoods/vim-systemd-syntax.git" },
		{ "https://github.com/lukas-reineke/indent-blankline.nvim.git" },
		{ "https://github.com/XXiaoA/atone.nvim.git" },
		{ "https://github.com/catgoose/nvim-colorizer.lua.git" },
		{ "https://github.com/stevearc/overseer.nvim.git" },
		{ "https://github.com/folke/snacks.nvim.git" },
		{ "https://github.com/mfussenegger/nvim-dap.git" },
		{ "https://github.com/mrcjkb/neotest-haskell.git" },
		{ "https://github.com/igorlfs/nvim-dap-view.git" },
		{ "https://github.com/theHamsta/nvim-dap-virtual-text.git" },
		{ "https://github.com/daic0r/dap-helper.nvim.git" },
		{ "https://github.com/ibhagwan/fzf-lua.git" },
		{ "https://github.com/numToStr/Navigator.nvim.git" },
		{ "https://github.com/nvim-lualine/lualine.nvim.git" },
		{ "https://github.com/liuchengxu/vista.vim.git" },
		{ "https://github.com/linrongbin16/lsp-progress.nvim.git" },
		{ "https://github.com/nvim-neotest/nvim-nio.git" },
		{ "https://github.com/kana/vim-niceblock.git" },
		{ "https://github.com/franco-ruggeri/codecompanion-lualine.nvim.git" },
		{ "https://github.com/Jorenar/nvim-dap-disasm.git" },
		{ "https://github.com/mfussenegger/nvim-dap-python.git" },
		{ "https://github.com/ribru17/blink-cmp-spell.git" },
		{ "https://github.com/Kaiser-Yang/blink-cmp-git.git" },
		{ "https://github.com/rgroli/other.nvim.git" },
		{ "https://github.com/Tsuzat/NeoSolarized.nvim.git" },
		{ "https://github.com/folke/lazy.nvim.git" },
		{ "https://github.com/Davidyz/VectorCode.git" },
		{ "https://github.com/mg979/vim-visual-multi.git" },
		{ "https://github.com/mfussenegger/nvim-lint.git" },
		{ "https://github.com/b0o/schemastore.nvim.git" },
		{ "https://github.com/iamcco/markdown-preview.nvim.git" },
		{ "https://github.com/farmergreg/vim-lastplace.git" },
		{ "https://github.com/nvim-mini/mini.nvim.git" },
		{ "https://github.com/folke/which-key.nvim.git" },
		{ "https://github.com/folke/lazydev.nvim.git" },
		{ "https://github.com/LiadOz/nvim-dap-repl-highlights.git" },
		{ "https://github.com/stevearc/conform.nvim.git" },
		{ "https://github.com/wsdjeg/vim-fetch.git" },
		{ "https://github.com/gbprod/yanky.nvim.git" },
		{ "https://github.com/JMarkin/gentags.lua.git" },
		{ "https://github.com/kkharji/sqlite.lua.git" },
		{ "https://github.com/chrisbra/Recover.vim.git" },
		{ "https://github.com/folke/trouble.nvim.git" },
		{ "https://github.com/andersevenrud/cmp-tmux.git" },
		{ "https://github.com/rachartier/tiny-code-action.nvim.git" },
		{ "https://github.com/saghen/blink.compat.git" },
		{ "https://github.com/tamago324/cmp-zsh.git" },
		{ "https://github.com/nmac427/guess-indent.nvim.git" },
		{ "https://github.com/junegunn/vim-peekaboo.git" },
		{ "https://github.com/timakro/vim-copytoggle.git" },
		{ "https://github.com/olimorris/codecompanion.nvim.git" },
		{ "https://github.com/nvim-neotest/neotest.git" },
		{ "https://github.com/lewis6991/gitsigns.nvim.git" },
		{ "https://github.com/ravitemer/mcphub.nvim.git" },
		{ "https://github.com/L3MON4D3/LuaSnip.git" },
		{ "https://github.com/saghen/blink.cmp.git" },
		{ "https://github.com/HakonHarnes/img-clip.nvim.git" },
		{ "https://github.com/rafamadriz/friendly-snippets.git" },
		{ "https://github.com/nvim-treesitter/nvim-treesitter-context.git" },
		{ "https://github.com/fang2hou/blink-copilot.git" },
		{ "https://github.com/ravitemer/codecompanion-history.nvim.git" },
		{ "https://github.com/olimorris/neotest-phpunit.git" },
		{ "https://github.com/nvim-neotest/neotest-python.git" },
		{ "https://github.com/nvim-neotest/neotest-go.git" },
		{ "https://github.com/MeanderingProgrammer/render-markdown.nvim.git" },
		{ "https://github.com/mfussenegger/nvim-ansible.git" },
		{ "https://github.com/franco-ruggeri/codecompanion-spinner.nvim.git" },
		{ "https://github.com/nvim-treesitter/nvim-treesitter.git" },
		{ "https://github.com/tzachar/highlight-undo.nvim.git" },
		{ "https://github.com/m-pilia/vim-pkgbuild.git" },
		{ "https://github.com/nvim-tree/nvim-web-devicons.git" },
		{ "https://github.com/ray-x/go.nvim.git" },
		{ "https://github.com/kshenoy/vim-signature.git" },
		{ "https://github.com/ray-x/guihua.lua.git" },
		{ "https://github.com/rcarriga/nvim-dap-ui.git" },
		{ "https://github.com/nvim-lua/plenary.nvim.git" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
