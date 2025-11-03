return {
    'stevearc/conform.nvim',
    config = function(_, opts)
        require("conform").setup(opts)
        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({ async = true, lsp_format = "fallback", range = range })
        end, { range = true })
    end,
    opts = {
        formatters_by_ft = {

            lua= { "stylua" },
            go = { "goimports", "gofmt"},
            php = { "phpcbf"},
            python = {"isort","trim_whitespace"},
            json = {"prettier", "jq"},
            yaml = {"prettier" },
            terraform= {"terraform_fmt"},
            -- Use the "*" filetype to run formatters on all filetypes.
            -- ["*"] = { "codespell" },
            -- Use the "_" filetype to run formatters on filetypes that don't
            --
            -- have other formatters configured.
            ["_"] = { "trim_whitespace" },
        },

        format_on_save = nil,
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
}
