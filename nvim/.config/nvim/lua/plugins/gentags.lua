return {
  {
    "linrongbin16/gentags.nvim",
    enabled = false,
    config = function()
      require('gentags').setup({

        ctags = {
          "--tag-relative=never",
        }
        })
    end,
  },
}
