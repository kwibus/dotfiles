return {
    {
        'mfussenegger/nvim-dap',
        ft = {'python'},
        init = function()
            vim.api.nvim_create_user_command("RunScriptWithArgs", function(t)
                local dap  = require('dap')
                -- :help nvim_create_user_command
                local args = vim.split(vim.fn.expand(t.args), '\n')
                local approval = vim.fn.confirm(
                    "Will try to run:\n    " ..
                    vim.bo.filetype .. " " ..
                    vim.fn.expand('%') .. " " ..
                    t.args .. "\n\n" ..
                    "Do you approve? ",
                    "&Yes\n&No", 1
                )
                if approval == 1 then
                    dap.run({
                        type = vim.bo.filetype,
                        request = 'launch',
                        name = 'Launch file with custom arguments (adhoc)',
                        program = '${file}',
                        args = args,
                    })
                end
            end, {
                    complete = 'file',
                    nargs = '*'
                })

            vim.keymap.set('n', '<leader>R', ":RunScriptWithArgs ")
            vim.keymap.set('n', '<leader>db', "<cmd>DapToggleBreak<CR>", { desc = "Toggle Breakpoint"})
            vim.keymap.set('n', '<F9>', "<cmd>DapStepOver<CR>", { desc = "Debug Step Over"}) 
            vim.keymap.set('n', '<F10>', "<cmd>DapStepInto<CR>", { desc = "Debug Step into"}) 
            vim.keymap.set('n', '<Shift-F10>', "<cmd>DapStepOut<CR>", { desc = "Debug Step out"}) 
            vim.keymap.set('n', '<F11>', "<cmd>DapContinue<CR>", { desc = "Debug Continue"}) 
        end,
    },{
        "rcarriga/nvim-dap-ui",
        ft = {'python'},
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup(opts)
            vim.keymap.set('n', '<leader>du', "<cmd>DapUiToggle<cr>", { desc = "Toggle Dap UI"})

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },{
        'theHamsta/nvim-dap-virtual-text',
        ft = {'python'},
        opts = {
            enabled = true,                        -- enable this plugin (the default)
            enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
            highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
            highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
            show_stop_reason = true,               -- show stop reason when stopped for exceptions
            commented = false,                     -- prefix virtual text with comment string
            only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
            all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
            clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
            --- A callback that determines how a variable is displayed or whether it should be omitted
            --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
            --- @param buf number
            --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
            --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
            --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
            --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
            display_callback = function(variable, buf, stackframe, node, options)
                -- by default, strip out new line characters
                if options.virt_text_pos == 'inline' then
                    return ' = ' .. variable.value:gsub("%s+", " ")
                else
                    return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
                end
            end,
            -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
            virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

            -- experimental features:
            all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
            virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
            virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
            -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
        }
    },{
        'mfussenegger/nvim-dap-python',
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    ft={'python'},
    config= function (_, opts)
            require("dap-python").setup()
            require('dap-python').test_runner = 'pytest'
            vim.keymap.set('n', '<leader>dm', ":lua require('dap-python').test_method()<CR>", { desc = "test method"})
            vim.keymap.set('v', '<leader>ds', ":lua require('dap-python').debug_selection()<CR>", { desc = "debug selection"})
    end,
    }

}

