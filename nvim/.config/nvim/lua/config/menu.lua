-- TODO: [x] Add debug, break points
-- TODO: [x] Can you add tooltip, keyboard shortcut? No
-- TODO: [x] Is it useful to have groups NO
-- TODO: [ ] -1- disabling does not work
-- TODO: [x] suppress warning if lsp is not implemented Done
-- TODO: [x] Goto tag is broken has_tags does not match same logic as <C-]> and C->
--           Might be the same as to to Definition?

-- inspired by: https://www.youtube.com/watch?v=_U54QKdFQno

local function has_lsp()
    return next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil
end
--------------------------------------------------------------------------------
-- Helpers: Custom Conditions (Sync)
--------------------------------------------------------------------------------

local function has_dap()
    ok, dap = pcall (require, 'dap')
    if ok then
        return dap.configurations[vim.bo.filetype] and #dap.configurations[vim.bo.filetype] > 0
    end
    return false
end

local function is_misspelled()
    if vim.opt.spell:get() then
        local word = vim.fn.expand('<cword>')
        if word and word ~= '' and #vim.spell.check(word) > 0 then
            return true
        end
    end
    return false
end

local function can_open()
    local file = vim.fn.expand('<cfile>')
    if file and file ~= '' then
        if file:match("^https?://") then return true end
        if vim.fn.filereadable(file) == 1 then return true end
    end
    return false
end

local function has_tag(_)
    local word = vim.fn.expand('<cword>')
    if word and word ~= "" then
        local tags = vim.fn.taglist("^" .. word .. "$")
        if #tags > 0 then
            return true
        end
    end
    return false
end

--------------------------------------------------------------------------------
-- Helpers: LSP Checks (Async)

-- These accept a 'ctx' table. They must set ctx.is_async = true and call ctx.done() when finished.
--------------------------------------------------------------------------------

-- Helper: Only start request if a client supports the method
local function safe_lsp_request(ctx, method, params_fn, result_handler)
    local clients = vim.lsp.get_clients({ bufnr = 0, method = method })

    if #clients == 0 then
        return false
    end

    local encoding = clients[1].offset_encoding
    local params = params_fn(encoding)

    ctx.is_async = true
    vim.lsp.buf_request(0, method, params, function(err, result)
        if result_handler then
            ctx.result = result_handler(err, result)
        else
            ctx.result = (not err and result and not vim.tbl_isempty(result))
        end
        ctx.done()
    end)
    return true
end

local function check_definition(ctx)
    return safe_lsp_request(ctx, "textDocument/definition", function(encoding)
        return vim.lsp.util.make_position_params(0, encoding)
    end)
end

local function check_type_definition(ctx)
    return safe_lsp_request(ctx, "textDocument/typeDefinition", function(encoding)
        return vim.lsp.util.make_position_params(0, encoding)
    end)
end

local function check_rename(ctx)
    return safe_lsp_request(ctx, "textDocument/prepareRename", function(encoding)
        return vim.lsp.util.make_position_params(0, encoding)
    end)
end

local function check_references(ctx)
    return safe_lsp_request(ctx, "textDocument/references", function(encoding)
        local params = vim.lsp.util.make_position_params(0, encoding)
        params.context = { includeDeclaration = true }
        return params
    end)
end

local function check_code_action(ctx)
    return safe_lsp_request(ctx, "textDocument/codeAction", function(encoding)
        local params = vim.lsp.util.make_range_params(0, encoding)
        params.context = { diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 }) }
        return params
    end)
end

local function check_signature_help(ctx)
    return safe_lsp_request(ctx, "textDocument/signatureHelp", function(encoding)
        return vim.lsp.util.make_position_params(0, encoding)
    end,
    function(err, result)

          return (not err and result and result.signatures and #result.signatures > 0)
      end)
  end

local function check_hover(ctx)
    return safe_lsp_request(ctx, "textDocument/hover", function(encoding)
        return vim.lsp.util.make_position_params(0, encoding)
    end)
end

local function check_implementation(ctx)
    return safe_lsp_request(ctx, "textDocument/implementation", function(encoding)
        return vim.lsp.util.make_position_params(0, encoding)
    end)
end


--------------------------------------------------------------------------------
-- Menu Configuration
--------------------------------------------------------------------------------
local pmenu = {
    -- & Should specify which key you have to press with alt, ass acceleration in some mythical gui like gvim
    -- <tab> should make text align right in some mythical gui vim version like gvim
    -- sub menu Popup.menu.submenu don't work with tui
    -- never seen both work in neovim based gui
      { "&Definition<tab>ls",   "<cmd>lua vim.lsp.buf.definition()<CR>",      cond = check_definition },
      { "&Hover",               "<cmd>lua vim.lsp.buf.hover()<CR>",           cond = check_hover },
    { "Re&name",              "<cmd>lua vim.lsp.buf.rename()<CR>",          cond = check_rename },
    { "&References",          "<cmd>FzfLua lsp_references<CR>",             cond = check_references },
    { "&Back",                "<C-t>" },
    -- { "-1-",                  cond = has_lsp},
      { "Type Definition",      "<cmd>lua vim.lsp.buf.type_definition()<CR>", cond = check_type_definition },
      { "Implementation",       "<cmd>lua vim.lsp.buf.implementation()<CR>",  cond = check_implementation },
    { "Signature Help",       "<cmd>lua vim.lsp.buf.signature_help()<CR>",  cond = check_signature_help },
    { "Code Action",          "<cmd>lua vim.lsp.buf.code_action()<CR>",     cond = check_code_action },
    -- { "-2-",                  cond = has_lsp},
    { "Jump to Tag",          "<C-]>",                                      cond = has_tag },
    { "Spelling Corrections", "z=",                                         cond = is_misspelled },
    { "Open",                 '<cmd>!xdg-open "<cfile>"<CR>',               cond = can_open },
    { "Break Points",         "<cmd>DapToggleBreak<CR>",                    cond = has_dap},
    -- { "-3-" },
    { "Cut",                  "+x",                                         mode = { "v" } },
    { "Copy",                 "+y",                                         mode = { "v" } },
    { "Copy",                 "<C-Y>",                                      mode = { "c" } },
    { "Paste",                "+gP",                                        mode = { "n" } },
    { "Paste",                "<C-R>+",                                     mode = { "c" } },
    { "Delete",               "x",                                          mode = { "v" } }
}

vim.cmd("aunmenu PopUp")

for _, v in ipairs(pmenu) do
    local label = string.gsub(v[1], " ", "\\ ")
    local command = v[2] or "<NOP>"
    local modes = v.mode or { "a" }
    for _, mode in ipairs(modes) do
        vim.cmd(string.format("%snoremenu PopUp.%s %s", mode, label, command))
    end
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        pcall(vim.api.nvim_del_augroup_by_name, "nvim.popupmenu")
    end
})

vim.api.nvim_create_autocmd("MenuPopup", {
    pattern = "*",
    desc = "Custom PopUp Setup",
    callback = function()
        local contexts = {}
        local pending_count = 0

        -- 1. Pass 1: Initiate all checks (Parallel)
        for i, item in ipairs(pmenu) do
            if item.cond then
                -- Create a context object for this check
                local ctx = {
                    is_async = false,
                    result = false,
                    done = function() pending_count = pending_count - 1 end
                }

                -- Call the function
                local status = item.cond(ctx)

                if ctx.is_async then
                    -- It's async! The function sets is_async=true and will call ctx.done() later
                    pending_count = pending_count + 1
                    contexts[i] = ctx
                else
                    -- It's sync! 'status' is the boolean result
                    contexts[i] = { result = status }
                end
            else
                contexts[i] = { result = true } -- No condition = always true
            end
        end

        -- 2. Pass 2: Wait for async ones (max 200ms)
        if pending_count > 0 then
            vim.wait(200, function() return pending_count == 0 end)
        end

        -- 3. Pass 3: Render Menu
        for i, item in ipairs(pmenu) do
            local label = string.gsub(item[1], " ", "\\ ")
            local modes = item.mode or { "a" }
            local enabled = contexts[i].result

            for _, mode in ipairs(modes) do
                if enabled then
                    vim.cmd(string.format("%smenu enable PopUp.%s", mode, label))
                else
                    vim.cmd(string.format("%smenu disable PopUp.%s", mode, label))
                end
            end
        end
    end,
})

