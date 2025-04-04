return {
  "tpope/vim-projectionist",
  config = function()
    vim.g.projectionist_heuristics = {
      ["*"] = {
        ["*.py"] = {
          alternate = "tests/{}_test.py",
        },
        ["src/test/java/*Test.java"] = {
          alternate = "src/main/java/{}.java",
        },
      },
    }
  end,
  -- event = "User AstroFile",
}
