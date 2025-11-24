return {
	{
		"mfussenegger/nvim-ansible",
		ft = "yaml",
	},
	{
		"m-pilia/vim-pkgbuild",
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		-- event = {"CmdlineEnter"},-- would make it load for every file
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	{
		ft = "lezer",
		"nono/lezer.vim"
	},{
		"wgwoods/vim-systemd-syntax",
		ft = { "service", "socket", "timer", "mount", "automount", "path","device", "container", },
	}
}
