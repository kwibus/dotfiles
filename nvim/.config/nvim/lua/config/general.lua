vim.g.loaded_node_provider = 0 -- don't want to use plugins written in node 
vim.g.loaded_perl_provider = 0 -- don't want to use plugins written in perl
vim.g.loaded_python3_provider = 0 -- don't want to use plugins written in python

vim.opt.secure  = true
-- don't fix end of file without enter.
vim.opt.fixendofline = false
--
-- show line number
vim.wo.number = true
-- merged signs and line numbers
-- vim.opt.signcolumn= "number"
vim.opt.mouse = "a"
vim.o.mousemoveevent = true
-- TODO how to get mouse click to select spell correction
vim.api.nvim_set_keymap('n', '<LeftMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.hover({border = "single"})<CR>', { noremap=true, silent=true })

vim.api.nvim_set_keymap('n', '<RightMouse>', '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true })

-- max height completion menu
vim.opt.pumheight = 6 -- TODO more completion option
-- about more is horrible, but not real alternative
-- vim.opt.more = false

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
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
  foldclose = '▸',
}
-- vim.opt.foldoptions = 'nodigits'
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
vim.opt.iskeyword:remove("_") -- don't move over camel case
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

    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
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
--- move to different file
-------------------------
-- Diff with last save --
-------------------------
vim.api.nvim_create_user_command('DiffWithSaved', function()
  -- Get current buffer info
  local cur_buf = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(cur_buf)

  -- Check if file exists on disk
  if filename == '' or not vim.fn.filereadable(filename) then
    vim.notify('File not saved on disk!', vim.log.levels.ERROR)
    return
  end

  local ft = vim.bo.filetype
  local cur_lines = vim.api.nvim_buf_get_lines(cur_buf, 0, -1, false)
  local saved_lines = vim.fn.readfile(filename)

  -- Create new tab
  vim.cmd 'tabnew'

  -- Function to create and setup a scratch buffer
  local function create_scratch_buffer(lines, title)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value('filetype', ft, { buf = buf })
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_set_option_value('winbar', title, { scope = 'local' })
    return buf
  end

  -- Create first scratch buffer with current content
  local buf1 = create_scratch_buffer(cur_lines, 'Unsaved changes')

  -- Create vertical split
  vim.cmd 'vsplit'

  -- Create second scratch buffer with saved content
  local buf2 = create_scratch_buffer(saved_lines, 'File on disk')

  -- Enable diff mode for both windows
  vim.cmd 'windo diffthis'

  -- Add keymapping to close diff view
  local function close_diff()
    vim.cmd 'tabclose'
  end

  vim.keymap.set('n', 'q', close_diff, { buffer = buf1, silent = true })
  vim.keymap.set('n', 'q', close_diff, { buffer = buf2, silent = true })
end, {})
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
