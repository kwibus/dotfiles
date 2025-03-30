return {
    'dense-analysis/ale',
    enabled = false,
    config = function()
        -- Configuration goes here.
        vim.g.ale_use_neovim_diagnostics_api = 1
        local g = vim.g
        g.ale_sign_error = ''
        g.ale_sign_warning = ''
        g.ale_linters = {
            python ={'flake8', 'ruff','mypy'},
            lua = {},
        --     lua = {'lua_language_server'}
        }
    end
}
