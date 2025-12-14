return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "igorlfs/nvim-dap-view",
            "daic0r/dap-helper.nvim", -- primary for persistence breakpoint
            "theHamsta/nvim-dap-virtual-text",
            "Jorenar/nvim-dap-disasm",
        },
        lazy = true,
        commands = {
            "DapClearBreakpoints",
            "DapContinue",
            "DapToggleBreak",
            "DapNew",
            "DapEval",
        },
        keys = {
            { mode = "n", "<leader>R", ":RunScriptWithArgs " },
            { mode = "n", "<leader>db", "<cmd>DapToggleBreak<CR>", desc = "Toggle Breakpoint" },
            { mode = "n", "<F9>", "<cmd>DapStepOver<CR>", desc = "Debug Step Over" },
            { mode = "n", "<F10>", "<cmd>DapStepInto<CR>", desc = "Debug Step into" },
            { mode = "n", "<Shift-F10>", "<cmd>DapStepOut<CR>", desc = "Debug Step out" },
            { mode = "n", "<F11>", "<cmd>DapContinue<CR>", desc = "Debug Continue" },
        },
        config = function()
            vim.cmd("hi DapBreakpointColor guifg=#fa4848")
            vim.fn.sign_define(
                "DapBreakpoint",
                { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" }
            )
            require("overseer").enable_dap()
            -- require("dap.ui.widgets").hover()
            vim.api.nvim_create_user_command("RunScriptWithArgs", function(t)
                local dap = require("dap")
                -- :help nvim_create_user_command
                local args = vim.split(vim.fn.expand(t.args), "\n")
                local approval = vim.fn.confirm(
                    "Will try to run:\n    "
                        .. vim.bo.filetype
                        .. " "
                        .. vim.fn.expand("%")
                        .. " "
                        .. t.args
                        .. "\n\n"
                        .. "Do you approve? ",
                    "&Yes\n&No",
                    1
                )
                if approval == 1 then
                    dap.run({
                        type = vim.bo.filetype,
                        request = "launch",
                        name = "Launch file with custom arguments (adhoc)",
                        program = "${file}",
                        args = args,
                    })
                end
            end, {
                complete = "file",
                nargs = "*",
            })

        end,
    },
    {
        "daic0r/dap-helper.nvim", -- primary for persistence breakpoint
        lazy = true,
        dependencies = {
            -- "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("dap-helper").setup()
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        cmd = { "DapUiToggle" },
        config = function(_, opts)
            -- local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(opts)
            vim.api.nvim_create_user_command("DapUiToggle", dapui.open, { desc = "Toggle Dap UI" })
            vim.keymap.set("n", "<leader>du", "<cmd>DapUiToggle<cr>", { desc = "Toggle Dap UI" })

            -- dap.listeners.before.attach.dapui_config = function()
            --     dapui.open()
            -- end
            -- dap.listeners.before.launch.dapui_config = function()
            --     dapui.open()
            -- end
            -- dap.listeners.before.event_terminated.dapui_config = function()
            --     dapui.close()
            -- end
            -- dap.listeners.before.event_exited.dapui_config = function()
            --     dapui.close()
            -- end
        end,
    },
    {
        "Jorenar/nvim-dap-disasm",
        lazy = true,
        dependencies = "igorlfs/nvim-dap-view",
        opts = {
            -- Add disassembly view to elements of nvim-dap-ui
            dapui_register = true,

            -- Add disassembly view to nvim-dap-view
            dapview_register = true,
        },
    },
    {
        "igorlfs/nvim-dap-view",
        lazy = true,
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
            winbar = {
                show = true,
                -- You can add a "console" section to merge the terminal with the other views
                sections = {
                    "watches",
                    "scopes",
                    "exceptions",
                    "breakpoints",
                    "threads",
                    "repl",
                    -- "console",
                    "sessions",
                    "disassembly", -- requires nvim-dap-disasm
                },
                -- Must be one of the sections declared above
                default_section = "breakpoints",
                -- Configure each section individually
                base_sections = {
                    breakpoints = {
                        keymap = "B",
                        label = "Breakpoints [B]",
                        short_label = " [B]",
                    },
                    scopes = {
                        keymap = "S",
                        label = "Scopes [S]",
                        short_label = "󰂥 [S]",
                    },
                    exceptions = {
                        keymap = "E",
                        label = "Exceptions [E]",
                        short_label = "󰢃 [E]",
                    },
                    watches = {
                        keymap = "W",
                        label = "Watches [W]",
                        short_label = "󰛐 [W]",
                    },
                    threads = {
                        keymap = "T",
                        label = "Threads [T]",
                        short_label = "󱉯 [T]",
                    },
                    repl = {
                        keymap = "R",
                        label = "REPL [R]",
                        short_label = "󰯃 [R]",
                    },
                    sessions = {
                        keymap = "K", -- I ran out of mnemonics
                        label = "Sessions [K]",
                        short_label = " [K]",
                    },
                    console = {
                        keymap = "C",
                        label = "Console [C]",
                        short_label = "󰆍 [C]",
                    },
                },
                -- Add your own sections
                custom_sections = {},
                controls = {
                    enabled = true,
                    position = "right",
                    buttons = {
                        "play",
                        "step_into",
                        "step_over",
                        "step_out",
                        "step_back",
                        "run_last",
                        "terminate",
                        "disconnect",
                    },
                    custom_buttons = {},
                },
            },
            windows = {
                height = 0.25,
                position = "below",
                terminal = {
                    width = 0.5,
                    position = "left",
                    -- List of debug adapters for which the terminal should be ALWAYS hidden
                    hide = {},
                    -- Hide the terminal when starting a new session
                    start_hidden = true,
                },
            },
            icons = {
                disabled = "",
                disconnect = "",
                enabled = "",
                filter = "󰈲",
                negate = " ",
                pause = "",
                play = "",
                run_last = "",
                step_back = "",
                step_into = "",
                step_out = "",
                step_over = "",
                terminate = "",
            },
            help = {
                border = nil,
            },
            render = {
                -- Optionally a function that takes two `dap.Variable`'s as arguments
                -- and is forwarded to a `table.sort` when rendering variables in the scopes view
                sort_variables = nil,
            },
            -- Controls how to jump when selecting a breakpoint or navigating the stack
            -- Comma separated list, like the built-in 'switchbuf'. See :help 'switchbuf'
            -- Only a subset of the options is available: newtab, useopen, usetab and uselast
            -- Can also be a function that takes the current winnr and the bufnr that will jumped to
            -- If a function, should return the winnr of the destination window
            switchbuf = "usetab,uselast",
            -- Auto open when a session is started and auto close when all sessions finish
            auto_toggle = true,
            -- Reopen dapview when switching to a different tab
            -- Can also be a function to dynamically choose when to follow, by returning a boolean
            -- If a function, receives the name of the adapter for the current session as an argument
            follow_tab = false,
        },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        opts = {
            enabled = true, -- enable this plugin (the default)
            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            show_stop_reason = true, -- show stop reason when stopped for exceptions
            commented = true, -- prefix virtual text with comment string
            only_first_definition = false, -- only show virtual text at first definition (if there are multiple)
            all_references = true, -- show virtual text on all all references of the variable (not only definitions)
            clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
            --- A callback that determines how a variable is displayed or whether it should be omitted
            --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
            --- @param buf number
            --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
            --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
            --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
            --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
            display_callback = function(variable, buf, stackframe, node, options)
                -- by default, strip out new line characters
                if options.virt_text_pos == "inline" then
                    return " = " .. variable.value:gsub("%s+", " ")
                else
                    return variable.name .. " = " .. variable.value:gsub("%s+", " ")
                end
            end,
            -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
            virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
        },
    },
    {
        "LiadOz/nvim-dap-repl-highlights",
        lazy = true,
        init = function()
            require("nvim-dap-repl-highlights").setup()
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        ft = { "python" },
        config = function(_, opts)
            require("dap-python").setup()
            require("dap-python").test_runner = "pytest"
            vim.keymap.set("n", "<leader>dm", ":lua require('dap-python').test_method()<CR>", { desc = "test method" })
            vim.keymap.set(
                "v",
                "<leader>ds",
                ":lua require('dap-python').debug_selection()<CR>",
                { desc = "debug selection" }
            )
        end,
    },
    {
        "leoluz/nvim-dap-go",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            require('dap-go').setup()
        end,
        ft = { "go" },
    }
}
