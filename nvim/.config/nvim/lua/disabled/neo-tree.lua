return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    enabled= false,
    lazy = false, -- neo-tree will lazily load itself
    opts = {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      source_selector = {
        winbar = true,
        statusline = true,
      },
      default_component_configs = {
        symlink_target = {
          enabled = true,

        }
        -- file_size = {
        --   enabled = true,
        --   width = 12, -- width of the column
        --   required_width = 64, -- min width of window required to show this column
        -- },
        -- type = {
        --   enabled = true,
        --   width = 10, -- width of the column
        --   required_width = 64, -- min width of window required to show this column
        -- },
      },
    }
  }
}
