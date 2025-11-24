return {
  {
    'rgroli/other.nvim',
    keys = {
      {"<leader>o", "<cmd>Other<cr>", desc="Other"}
    },
    cmd = {
      "Other"
    },
    config = function ()
      require("other-nvim").setup({
      mappings = {
        "livewire",
        "angular",
        "laravel",
        "rails",
        "golang",
        "python",
        "react",
        "rust",
        "elixir",
        {
            pattern = "(.*).c$",
            target = "%1.h",
            context =  'header'
        }, {
            pattern = "(.*).h$",
            target = "%1.c",
            context =  'src'
        }, {
            pattern = "tests/(.*)_test%.py$",
            target = "*/%1.py",
            context =  'src'
        }, {
            pattern = "(.*)/(.*)%.py$",
            target = "tests/**/%2_test.py",
            context =  'test'
        }, {
            pattern = "tests/(.*)_test.php$",
            target = "*/%1.php",
            context =  'src'
        }, {
            pattern = "(.*)/(.*).php$",
            target = "tests/**/%2_test.php",
            context =  'test'
        }
      },
      })
    end
  }
}
