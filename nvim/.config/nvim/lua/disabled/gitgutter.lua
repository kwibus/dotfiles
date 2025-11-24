return {
    "airblade/vim-gitgutter",
    enabled=false,
    lazy=false,
    config = function ()
        vim.cmd.GitGutterEnable()
    end,
    keys = {
        { "]h", "<Plug>(GitGutterNextHunk)" },
        { "[h", "<Plug>(GitGutterPrevHunk)" },

        {"ih", "<Plug>(GitGutterTextObjectInnerPending)", mode="o"},
        {"ah", "<Plug>(GitGutterTextObjectOuterPending)", mode="o"},
        {"ih", "<Plug>(GitGutterTextObjectInnerVisual)", mode="x"},
        {"ah", "Plug>(GitGutterTextObjectOuterVisual", mode="x"},
    },
}
