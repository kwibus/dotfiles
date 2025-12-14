


vim.g.loaded_node_provider = 0 -- don't want to use plugins written in node
vim.g.loaded_perl_provider = 0 -- don't want to use plugins written in perl
vim.g.loaded_python3_provider = 0 -- don't want to use plugins written in python
vim.g.loaded_ruby_provider = 0-- don't want to use plugins written in ruby
vim.opt.secure  = true
-- don't fix end of file without enter.
vim.opt.fixendofline = false

if vim.fn.has('nvim-0.12') == 1 then
  vim.o.pumborder = 'single' -- popup menu border # TODO does not work with
end
vim.o.winborder = "single"
-- show line number
vim.wo.number = true
-- merged signs and line numbers
-- vim.opt.signcolumn= "number"
vim.opt.mouse = "a"
vim.o.mousemoveevent = true
-- TODO: how to get mouse click to select spell correction

-- Don't mark URL-like things as spelling errors
-- vim.cmd.syntax.([ syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell ])
-- "vim.cmd [==[
-- "  syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell
-- "]==]

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    vim.lsp.inlay_hint.enable() -- TODO try
  end
})
-- vim.api.nvim_set_keymap(
--   'n',
--   '<LeftMouse>',
--   '<LeftMouse><cmd>lua vim.lsp.buf.hover({border = "single"})<CR>',
--   { noremap=true, silent=true }
-- )

-- vim.api.nvim_set_keymap(
--   'n',
--   '<RightMouse>',
--   '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>',
--   { noremap=true, silent=true }
-- )

-- max height completion menu
vim.opt.pumheight = 6 -- TODO more completion option
-- about more is horrible, but not real alternative
-- vim.opt.more = false

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
-- show white space characters
vim.opt.list = true
vim.opt.listchars = {
  tab='▸ ',
  eol='¬',
  trail='_',
  extends='#',
  nbsp = '.'
}

vim.opt.laststatus = 3

-- better performance large files
vim.opt.synmaxcol = 5000
vim.opt.clipboard = "unnamedplus"

-- undo
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
vim.opt.undofile = true
vim.fn.mkdir(prefix .. "/nvim/undo//", "p")
vim.opt.undodir = { prefix .. "/nvim/undo//"}
vim.fn.mkdir(prefix .. "/nvim/backup//", "p")
vim.opt.backupdir = {prefix .. "/nvim/backup//"}


-- tab and indent
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- fold with treesitter

vim.o.foldenable = true
vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr =  "v:lua.vim.lsp.foldexpr()" # often not supported
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = ""
-- vim.opt.foldlevelstart=99
vim.wo.foldlevel=99
-- maybe plugin can do this better
vim.opt.foldcolumn="1"
vim.opt.fillchars = {
  -- vert = ' ', -- alternatives │
  fold = ' ',
  -- eob = ' ', -- suppress ~ at End Of Buffer
  -- diff = '─', -- alternatives: ⣿ ░
  -- msgsep = '‾',
  foldopen = '▾',
  -- foldsep = ' ',
  foldclose = '▸'
}

if vim.fn.has('nvim-0.12') == 1 then
  vim.opt.fillchars.foldinner = ' '
end
--
-- allow visual block to select as block
vim.opt.virtualedit={"block","onemore"}

-- scroll before cursor edge of scree
vim.opt.scrolloff=7
vim.opt.hidden=false
vim.opt.confirm=true

-- set spell
vim.wo.spell = true
vim.opt.spelllang={"en","nl"}
vim.opt.spelloptions="camel"

vim.api.nvim_set_hl(0,'SpellBad',{undercurl=true, sp='red'})

-- TODO window zoom in

-- vim.opt.iskeyword:remove("_") -- don't move over camel case
-- what to store re restore from session
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

--
--
-- vim.highlight.
-- lower priority of semantic_tokens set by lsp because the highlight color todo is better in treesitter is better?
vim.hl.priorities.semantic_tokens = 95

-- diagnostics
vim.diagnostic.config{
    virtual_text  = {
        prefix = '●',  -- Could be '●', '▎', 'x'
        source = "if_many",
    },
    float = {
      source = 'always',
      border = border
    },
    underline = true,
    signs = {

        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
        },
        linehl = {
            -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        },
        numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
   --      format = function(diagnostic)
			-- return string.format(
			-- 	"%s (%s) [%s]",
			-- 	diagnostic.message,
			-- 	diagnostic.source,
			-- 	diagnostic.code or diagnostic.user_data.lsp.code
			-- )
        -- end,
    },
}
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- -- jinja support
-- vim.filetype.add({
--   extension = {
--     jinja2 = 'jinja2',
--   },
--   pattern = {
--     [".*%.j2"] = "jinja2",
--     [".*j2%"] = "jinja2",
--   },
-- })

-- HELM filetype detection
vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})
-- vscode settings.json can contain comments
vim.filetype.add({
  filename = {
    ['settings.json'] = 'jsonc'
  },
  pattern = {
    [".*/.vscode/.*.json"] = "jsonc",
    [".*/waybar/config"] = "jsonc",
  }
})

vim.filetype.add({
  pattern = {
    [".*.container"] = "systemd",
  }
})
--- move to different file
-------------------------
-- Diff with last save --
-------------------------
-- for some reason does not work if not done in autocmd
vim.api.nvim_create_autocmd("BufEnter", {
  buffer = 0,
  callback = function()
    vim.opt_local.formatoptions:remove{"o","r","c"} -- don't add comment when creating new line
  end,
})
-- set commentstring hcl
vim.cmd [[
  au FileType hcl,terraform setlocal commentstring=#\ %s
]]
