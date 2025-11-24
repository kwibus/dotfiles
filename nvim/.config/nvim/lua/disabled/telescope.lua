return {
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        enabled = false,
        dependencies = {
            'nvim-lua/plenary.nvim',

        },
        cmd = "Telescope",
        keys = {
            {"<F12>", "<cmd>Telescope find_files<cr>"},
            {"<leader>ff", "<cmd>Telescope find_files<cr>", desc= 'Telescope find files'},
            {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc= 'Telescope live grep'},
            {"<leader>fb", "<cmd>Telescope buffers<cr>", desc= 'Telescope buffers'},
            {"<leader>fh", "<cmd>Telescope help_tags<cr>", desc= 'Telescope help tags'},
        },
        opts = {
            defaults = {
                preview = {
                    mime_hook = function(filepath, bufnr, opts)
                        local is_image = function(filepath)
                            local image_extensions = {'png','jpg'}   -- Supported image formats
                            local split_path = vim.split(filepath:lower(), '.', {plain=true})
                            local extension = split_path[#split_path]
                            return vim.tbl_contains(image_extensions, extension)
                        end
                        if is_image(filepath) then
                            local term = vim.api.nvim_open_term(bufnr, {})
                            local function send_output(_, data, _ )
                                for _, d in ipairs(data) do
                                    vim.api.nvim_chan_send(term, d..'\r\n')
                                end
                            end
                            vim.fn.jobstart(
                                {
                                    'catimg', filepath  -- Terminal image viewer command
                                }, 
                                {on_stdout=send_output, stdout_buffered=true, pty=true})
                        else
                            require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
                        end
                    end
                },
            }
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
