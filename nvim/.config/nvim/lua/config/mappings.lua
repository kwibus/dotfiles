-- commands
-- common typos
vim.api.nvim_create_user_command('Q','q',{})
vim.api.nvim_create_user_command('WQ','wq',{})
vim.api.nvim_create_user_command('Wq','wq',{})
vim.api.nvim_create_user_command('W','w',{})
--
vim.api.nvim_create_user_command('SudoWrite', [[ execute ':silent w !sudo tee %']], {})
--
-- emacs compatible
vim.keymap.set('n', '<C-a>', "<Esc>^", { desc = 'To start Normal' })
vim.keymap.set('i', '<C-a>', "<Esc>I", { desc = 'To start Insert' })
vim.keymap.set('c', '<C-a>', "<Home>", { desc = 'To start Insert' })
--
vim.keymap.set('n', '<C-e>', "<Esc>g_", { desc = 'To end Normal' })
vim.keymap.set('i', '<C-e>', "<Esc>g_a", { desc = 'To end Insert' })

vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("c", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-H>", "<C-w>") -- using Ctrl+Backspace delete a word. ref:https://www.reddit.com/r/neovim/comments/prp8zw/using_ctrlbackspace_in_neovim/
vim.keymap.set("c", "<C-H>", "<C-w>")

vim.keymap.set('n','<C-TAB>', '<cmd>:tabnext<CR>', {desc = 'Next tab'}) -- does only work with some help in kitty
vim.keymap.set('n','<S-C-TAB>', '<cmd>:tabprevious<CR>', {desc = 'Previous tab'}) -- does not work
-- vim.keymap.set('n' <C-t>    <Esc>:tabnew<CR>
--
-- Walk over wrapped lines.
vim.keymap.set('n', 'j', 'gj', {silent = true})
vim.keymap.set('n', 'k', 'gk', {silent = true})
-- maybe replace with
-- vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- does same as r and is anying with surround
vim.api.nvim_set_keymap("n", "s", "<Nop>", { noremap = true, silent = true })
--
-- alternative for https://github.com/dhruvasagar/vim-zoom
vim.keymap.set('n', '<C-w>z', ":tab split<CR>", { desc = 'zoomin with tab' })

-- Quickfix list
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Previous quickfix item' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix item' })

-- Diagnostics
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to prev diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- I use Trouble <leader> xx more.
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic quickfix list' })

-- is the default neovim now
-- vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
-- vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
-- vim.keymap.set('n', 'grr', vim.lsp.buf.references)

vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
vim.keymap.set(
    'n',
    '<F6>',
    function()vim.diagnostic.enable(not vim.diagnostic.is_enabled())end,
    { silent = true, noremap = true }
)

-- vim.keymap.set({'i','n','v'}, '<ScrollWheelUp>','<C-u>', {desc= 'Scroll Up'} )
-- vim.keymap.set({'i','n','v'}, '<ScrollWheelDown>','<C-d>', {desc= 'Scroll Down'} )
