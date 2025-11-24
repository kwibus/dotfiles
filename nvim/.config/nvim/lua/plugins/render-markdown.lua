return {
   -- watch out this plugin is also as dependencies of Avante
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {
      completions = { lsp = { enabled = true } },
      heading = {
        sign = false,  -- Makes screen redraw every time you hid insert mode
    }
  },
  config = function(_, opts)
    -- Otherwise code block have same syntax group visual select ColorColumn
    vim.api.nvim_set_hl(0, "RenderMarkdownCode", { link='Cursorline' }) 
    require('render-markdown').setup({})
  end,
}
