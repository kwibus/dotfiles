return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  -- enabled = false,
  opts = {
    input = {},
    -- image= {},
    picker = {},
    notifier = {
          enabled = true,
          -- Optional: Configure the notifier further
          timeout = 3000, -- Messages disappear after 3 seconds by default
          style = "compact", -- Or "compact", "minimal"
          -- level = vim.log.levels.INFO, -- Minimum log level to display
          -- keep = function(notif) return vim.fn.getcmdpos() > 0 end, -- Example
    },
    -- ---@class snacks.words.Config
    -- ---@field enabled? boolean
    -- words = {
    --   debounce = 200, -- time in ms to wait before updating
    --   notify_jump = false, -- show a notification when jumping
    --   notify_end = true, -- show a notification when reaching the end
    --   foldopen = true, -- open folds after jumping
    --   jumplist = true, -- set jump point before jumping
    --   modes = { "n", "i", "c" }, -- modes to show references
    --   filter = function(buf) -- what buffers to enable `snacks.words`
    --     return vim.g.snacks_words ~= false and vim.b[buf].snacks_words ~= false
    --   end,
    -- },
    ---@class snacks.statuscolumn.Config
    ---@field enabled? boolean
    statuscolumn = {
      left = { "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    }
  }
}
