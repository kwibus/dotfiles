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
        "nono/lezer.vim",
    },
    {
        "wgwoods/vim-systemd-syntax",
        ft = { "service", "socket", "timer", "mount", "automount", "path", "device", "container" },
    },
    {
        "mrcjkb/rustaceanvim",
        dependencies = { "nvim-neotest/neotest" },
        -- version = "^6", -- Recommended
        lazy = false, -- This plugin is already lazy
        ft = { "rust","toml" },
        config = function(_, opts)

            local adapter = require('rustaceanvim.neotest')
            local adapters = require("neotest.config").adapters
            table.insert(adapters, adapter)
        end
    },
    {
        "scalameta/nvim-metals",
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()
            metals_config.on_attach = function(client, bufnr)
                -- your on_attach function
            end
            metals_config.settings = {
                javaHome = "/usr/lib/jvm/java-25-openjdk"
            }

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                    require("metals").setup_dap()
                end,
                group = nvim_metals_group,
            })
        end
    }
}
