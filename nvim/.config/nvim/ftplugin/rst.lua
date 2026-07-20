-- esbonio (Sphinx / reStructuredText LSP). Installed outside nvim via uv:
--   uv tool install esbonio --with sphinx --with pyyaml --with sphinx-h5p \
--       --with sphinxcontrib-exercise --with sphinxcontrib-pdf2svg \
--       --with sphinxcontrib-ditaa --with attheme-tonk-latex
-- (the builtin ftplugin/rst.vim still applies its defaults on top of this)

-- Merge-based + idempotent, so it's fine to (re)apply on every rst buffer and
-- it picks up edits when re-sourced.
vim.lsp.config("esbonio", {
    cmd = { "esbonio", "server" }, -- 2.0+: 'server' subcommand; bare 'esbonio' just prints help
    filetypes = { "rst" }, -- or 'markdown' if you use MyST
    -- root = the dir containing conf.py (e.g. docs/), so cwd lands there:
    -- sphinx-build '.' finds conf.py, and conf.py's open('../config.yml') resolves to the training root.
    root_markers = { "conf.py" },
    settings = {
        esbonio = {
            sphinx = {
                buildCommand  = { "sphinx-build", "-M", "dirhtml", ".", "${defaultBuildDir}" },
                pythonCommand = { vim.fn.expand("~/.local/share/uv/tools/esbonio/bin/python") },
            },
        },
    },
})

-- enable() re-fires doautoall across all buffers on every call, so only do it once.
if not vim.lsp.is_enabled("esbonio") then
    vim.lsp.enable("esbonio")
end

-- Live HTML preview, per esbonio's "Live Previews" docs:
-- https://docs.esbon.io/en/release/integrating/previews.html
local function scroll_view()
    local client = vim.lsp.get_clients({ name = "esbonio", bufnr = 0 })[1]
    if not client then return end
    -- `line` = the line visible at the top of the window; keeps the browser in sync
    local view = vim.fn.winsaveview()
    client:notify("view/scroll", { uri = vim.uri_from_bufnr(0), line = view.topline })
end

-- buffer-local: :EsbonioPreviewFile only exists in rst buffers
vim.api.nvim_buf_create_user_command(0, "EsbonioPreviewFile", function()
    local client = vim.lsp.get_clients({ name = "esbonio", bufnr = 0 })[1]
    if not client then
        vim.notify("esbonio is not attached to this buffer", vim.log.levels.WARN)
        return
    end
    -- esbonio opens the browser itself via a window/showDocument request
    client:request("workspace/executeCommand", {
        command = "esbonio.server.previewFile",
        arguments = { { uri = vim.uri_from_bufnr(0) } },
    }, nil, 0)

    local augroup = vim.api.nvim_create_augroup("EsbonioSyncScroll", { clear = true })
    vim.api.nvim_create_autocmd("WinScrolled", {
        group = augroup,
        buffer = 0,
        callback = scroll_view,
    })
end, { desc = "Esbonio: live HTML preview of current file (scroll-synced)" })
