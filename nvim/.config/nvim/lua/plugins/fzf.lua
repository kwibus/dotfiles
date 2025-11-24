return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  cmd = "FzfLua",
  keys = {
    {"<F12>", "<cmd>FzfLua files <cr>",  desc= 'Fzf files'},
    {"<leader>ff", "<cmd>FzfLua files <cr>", desc= 'fzf files'},
  }
}
