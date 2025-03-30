return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "VeryLazy" },
        config = function(_, opts)
            local configs = require("nvim-treesitter.configs")
            configs.setup(opts)
        end,
        opts = {
            auto_install = true,
            ensure_installed = {
                "comment",
                "c",
                "cpp",
                "haskell",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "html",
                "php",
                "python",
                "dot",
                "dockerfile"
            },
            sync_install = false,
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>o", -- set to `false` to disable one of the mappings
                    node_incremental = "o",
                    scope_incremental = "grc",
                    node_decremental = "O",
                },
            },
            highlight = {
                enable = true,
                -- disable = { "tmux" },    -- tmux highlight treesitter is ugly.
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = function(lang, buf)
                    if lang == 'tmux' then
                        return true -- syntax highlight treesitter looks ugly
                    end
                    local max_filesize = 1024 * 1024
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats then
                        if stats.size > max_filesize then
                            print('disabled treesitter: file to large')
                            return true
                        elseif stats.size / vim.api.nvim_buf_line_count(buf) > 1000 then
                            print('disabled treesitter: lines in file to long')
                            return true
                        end
                    end
                    return false
                end,
            },

            additional_vim_regex_highlighting = false,
        }
    }, {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle"
    }
}
