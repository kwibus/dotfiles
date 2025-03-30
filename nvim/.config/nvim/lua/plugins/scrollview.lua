return {
    "dstein64/nvim-scrollview",
    -- enabled=false,
    opts = {
        excluded_filetypes = {'nerdtree'},
        current_only = true,
        base = 'right',
        -- column = 80,
        signs_on_startup = {'all'},
        -- diagnostics_severities = {vim.diagnostic.severity.ERROR}
    }
}
