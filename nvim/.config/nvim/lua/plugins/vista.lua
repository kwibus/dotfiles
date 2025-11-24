return {
  {
  "liuchengxu/vista.vim",
  cmd = {"Vista"}
  },
  -- {
  --   "linrongbin16/gentags.nvim",
  --   config = function()
  --     require('gentags').setup()
  --   end,
  -- },
  {
    "JMarkin/gentags.lua",
    cond = vim.fn.executable("ctags") == 1,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = {}
  }
}
