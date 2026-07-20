return {
    "iamkarasik/sonarqube.nvim",
    config = function()
      require("sonarqube").setup({
          rules = {
              enabled = true,
              ["python:S1135"]= { enabled = false },  -- disable TODO/FIXME
              ["python:S8410"]= { enabled = false },  -- FastAPI Annotate vs Depends
              ["javascript:S7764"] = { enabled = false },  -- prefer globThis
              ["javascript:S1135"]= { enabled = false }, -- TODO comments
              ["Web:S1135"] = { enabled = false },  -- TODO comments
          }
      })
    end
}
