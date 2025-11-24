return {
    "mfussenegger/nvim-lint",
    event = {"VeryLazy"},
    config = function ()
        local lint = require("lint")

        -- ignore unknown globals like `vim` in lua files
        local luacheck = lint.linters.luacheck
        luacheck.args = { '--formatter', 'plain', '--codes', '--ranges', '-g', '-' }

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            lua = {"luacheck"},
            sh = {"shellcheck"},
            dockerfile = {"hadolint"},
            python = { "ruff", "mypy",},
            php = {"phpcs"}, -- "phpmd"}
            yaml = {"yamllint"},
            rst = {"rstcheck"},
            ansible = {"ansible_lint"}, -- ansible-language-server is better
            terraform = {"tflint"},
        }
        local shellcheck = lint.linters.shellcheck
        table.insert(shellcheck.args,"-x")

        local rstcheck = lint.linters.rstcheck
        rstcheck.args = {
            '--ignore-messages', 'is not referenced',
            '--ignore-substitutions', "notes, slide",
            '--ignore-directives', "exercise"
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()

                if vim.bo.filetype == "trouble" then
                    return
                else
                    lint.try_lint()
                    lint.try_lint('codespell')
                end
            end,
        })
        ---- Show linters for the current buffer's file type 
        ---https://github.com/mfussenegger/nvim-lint/issues/559
        vim.api.nvim_create_user_command("LintInfo", function()
            local filetypes = vim.bo.filetype
            for filetype in filetypes:gmatch('[^.]+') do
                local linters = require("lint").linters_by_ft[filetype]
                if linters then
                    print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
                else
                    print("No linters configured for filetype: " .. filetype)
                end
            end
        end, {})
        -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        --     callback = function()
        --
        --         --
        --         -- try_lint without arguments runs the linters defined in `linters_by_ft`
        --         -- for the current file type
        --         require("lint").try_lint()
        --     end,
        -- })
    end,
}
