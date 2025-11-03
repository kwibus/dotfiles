return {
  {
    -- 'y3owk1nr/undo-glow.nvim',
    'tzachar/highlight-undo.nvim',
  --   -- enabled = false,
    opts = {
        hlgroup = "HighlightUndo",
        duration = 500,
        pattern = {"*"},
        ignored_filetypes = { "neo-tree", "fugitive", "TelescopePrompt", "mason", "lazy" },
        -- ignore_cb is in comma as there is a default implementation. Setting
        -- to nil will mean no default os called.
        -- ignore_cb = nil,

    },
  },
}

