return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      -- "antoinemadec/FixCursorHold.nvim",  -- not required modern neovim
      "nvim-treesitter/nvim-treesitter",
      'stevearc/overseer.nvim',
    },
    cmd = "Neotest",
    keys = {
      {
        "<leader>tm",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>tt",
        function()
          local neotest = require("neotest")
          local test_file = vim.fn.expand("%")
          -- check if current file has test
          local has_tests = false
          for _, adapter_id in ipairs(neotest.state.adapter_ids()) do
           local positions = neotest.state.positions(adapter_id, { buffer =  vim.api.nvim_get_current_buf()})
           if positions and #positions:children() > 0 then
             has_tests = true
             break
           end
         end

         -- if neotest.run.get_tree_from_args(test_file,true) then
         if has_tests  then
           neotest.run.run(test_file)
         else
            local others = require("other-nvim").findOther(vim.fn.expand("%"), "test")
            if next(others) ~= nil then
               test_file = others[1].filename
               vim.notify("Use: " .. test_file, vim.log.levels.INFO)
               neotest.run.run(test_file)
            end
          end
        end,
        desc = "Run test",
      },
      -- {
      --   "<leader>tr",
      --   function()
      --     local others = require("other-nvim").findOther(vim.fn.expand("%"), "test")
      --     for _, v in pairs(others) do
      --       if v.exists then
      --         require("neotest").run.run(v.filename)
      --         break
      --       end
      --     end
      --   end,
      -- },
      {
        "<leader>ta",
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "Run all test",
      },
      {
        "<leader>ts",
        "<cmd>Neotest summary<cr>",
        desc = "Summary test",
      },
      {
        "<leader>to",
        "<cmd>Neotest output-panel<cr>",
        desc = "Output test",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Watch test",
      },
    },
    opts = {},
    config = function(_, opts)
      require("neotest").setup({
        -- no adapters registered on initial setup, There are loaded only when needed
        adapters = {},
        consumers = {
          overseer = require("neotest.consumers.overseer")
        },
      })
    end,
  },
  {

    "olimorris/neotest-phpunit",
    ft = "php",
    dependencies = { "nvim-neotest/neotest" },
    config = function(_, opts)
      local adapter = require("neotest-phpunit")(opts)
      local adapters = require("neotest.config").adapters
      table.insert(adapters, adapter)
    end,
  },
  {
    "nvim-neotest/neotest-python",
    dependencies = { "nvim-neotest/neotest" },
    ft = "python",
    opts = {
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = { justMyCode = false },
      -- Command line arguments for runner
      -- Can also be a function to return dynamic values
      -- args = {"--log-level", "DEBUG"},
      -- Runner to use. Will use pytest if available by default.
      -- Can be a function to return dynamic value.
      runner = "pytest",
      -- Custom python path for the runner.
      -- Can be a string or a list of strings.
      -- Can also be a function to return dynamic value.
      -- If not provided, the path will be inferred by checking for
      -- virtual envs in the local directory and for Pipenev/Poetry configs
      -- python = ".venv/bin/python",
      -- Returns if a given file path is a test file.
      -- NB: This function is called a lot so don't perform any heavy tasks within it.
      -- is_test_file = function(file_path)
      --     return true
      -- end,
      -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
      -- instances for files containing a parametrize mark (default: false)
      pytest_discover_instances = true,
    },
    config = function(_, opts)
      local adapter = require("neotest-python")(opts)
      local adapters = require("neotest.config").adapters
      table.insert(adapters, adapter)
    end,
  },
  {
    "nvim-neotest/neotest-go",
    ft = "go",
    dependencies = { "nvim-neotest/neotest" },
    config = function(_, opts)
      local adapter = require("neotest-go")(opts)
      local adapters = require("neotest.config").adapters
      table.insert(adapters, adapter)
    end,
  },
  {
    'mrcjkb/neotest-haskell',
    ft = "haskell",
    dependencies = { "nvim-neotest/neotest" },
    config = function()
      -- default frameworks: tasty, hspec, sydtest (auto-detected via cabal/stack)
      table.insert(require("neotest.config").adapters, require("neotest-haskell"))
    end,
  },
  {
    'rcasia/neotest-bash',
    dependencies = { "nvim-neotest/neotest" },
    ft = {"bash","sh"},
    config = function ()
      local adapter = require("neotest-bash")({
        executable = "/bin/bash_unit",
        -- executable = "bashunit",
      })
      local adapters = require("neotest.config").adapters
      table.insert(adapters, adapter)
    end,
  }
}
