return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  ---@class wk.Opts
  opts = { 
    -- preset = "classic",
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  delay = function(ctx)
    return ctx.plugin and 0 or 800
  end,
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true})
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
