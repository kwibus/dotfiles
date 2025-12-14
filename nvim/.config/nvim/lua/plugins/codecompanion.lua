return {
  {
    "olimorris/codecompanion.nvim",
    -- version = '17.*',
    -- "kwibus/codecompanion.nvim",
    -- dir = "~/projects/codecompanion.nvim",
    event = {"VeryLazy"},
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-treesitter/nvim-treesitter",
      { "ravitemer/mcphub.nvim",

      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      lazy = true,
      build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
      config = function()
        require("mcphub").setup({
        })

      end
    },
      "HakonHarnes/img-clip.nvim",
      -- "Davidyz/VectorCode",
      "ravitemer/codecompanion-history.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
      -- "mimikun/codecompanion-reasoning.nvim",
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
      "CodeCompanionHistory",
      "CodeCompanionSummaries"
    },
    keys = {
      { mode = { "n", "v" }, "<C-a>" , "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
      { mode = { "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanion Chat" },
      { mode = "v", "ga", "<cmd>CodeCompanionChat Add<cr>", desc = "Add selection to CodeCompanion Chat" },
      { mode = "v",
        "<leader>A",
        function()

          local saved_view = vim.fn.winsaveview()

          -- Prompt the user for input
          vim.ui.input({
            prompt = "CodeCompanion prompt: ",
            -- Optionally, you can enable command completion within the input prompt
            completion = "command"
          }, function(user_input)
              -- Restore the view immediately. This will exit visual mode and put the
              -- cursor back where it was, but the '< and '> marks (start/end of visual
              -- selection) will still be valid for the last visual selection.
              vim.fn.winrestview(saved_view)

              if user_input then
                -- User confirmed the input.
                -- Escape the user's input to ensure it's safely passed as an argument
                -- to the Vim command, especially if it contains spaces or special characters.
                local escaped_input = vim.fn.shellescape(user_input, true)

                -- Construct the full Ex command string.
                -- The '<,'> range automatically refers to the last visual selection,
                -- regardless of whether it was character-wise, line-wise, or block-wise.
                local command_to_execute = string.format("'<,'>CodeCompanion %s", escaped_input)

                -- Execute the command using nvim_command. This directly runs the Ex command.
                vim.api.nvim_command(command_to_execute)
              else
                vim.notify("CodeCompanion command cancelled.", vim.log.levels.INFO)
              end
            end)
        end,
        desc = "Add selection to CodeCompanion Chat" },
    },
    cond = function ()
      return not vim.g.vscode -- don`t run in vscode
    end,
    opts = {
      log_level = "TRACE", -- or "TRACE"
      opts = {
        log_level = "TRACE", -- or "TRACE"
      },
      collapse_tools = false,
      display = {
        diff ={
          enabled = true,
          provider = "inline", -- default|mini_diff
          provider_opts = {
            -- Options for inline diff provider
            inline = {
              layout = "buffer", -- float|buffer - Where to display the diff
            }
          }
        },
        chat = {
          icons = {
            chat_context = "📎️", -- You can also apply an icon to the fold
          },
          -- show_header_separator = true,
          -- show_settings = true, -- Show LLM settings at the top of the chat buffer?
          show_tools_processing = true,
          fold_context = true,
        }
      },
      interactions = {
        chat = {
          adapter = "gemini",
          opts = {
            ---@param ctx CodeCompanion.SystemPrompt.Context
            ---@return string
            system_prompt = function(ctx)
              return ctx.default_system_prompt .. string.format(
                [[ The current date is %s.
The user is working on a %s machine. Please respond with system specific commands if applicable.
Your current working directory is: %s
This project root is: %s ]],
                ctx.date,
                ctx.os,
                ctx.cwd,
                ctx.project_root
              )
            end,
            },
            -- roles = {
              --   user = function (adapter)
          --     return 'Ask: ' ..  adapter.model.name
          --   end,
          -- },

          -- },
          tools = {
            opts = {
              -- auto_submit_errors = true, -- Send any errors to the LLM automatically?
              -- auto_submit_success = true, -- Send any successful output to the LLM automatically?
              default_tools = {
                "files",
                "fetch_webpage",
                "search_web",
                "web_search",
                "web_fetch",
                "code_execution",
                -- "vectorcode_toolbox",
                -- "next_edit_suggestion",
                "list_code_usages",
                "memory",
                -- "sequentialthinking",
                "context7",
              }
            }
          },
          slash_commands = {
            ["file"] = {
              -- Location to the slash command in CodeCompanion
              callback = "interactions.chat.slash_commands.builtin.file",
              description = "Select a file using Snack",
              opts = {
                provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
                contains_code = true,
              },
            }
          },
        },
        inline = {
          adapter = "gemini",
        },
        cmd = {
          adapter = "gemini",
        },
        background = {
          adapter = "gemini",
        }
      },
      rules = {
        opts = {
          chat = {
            enabled = true,
          },
        },
      },
      adapters = {
        http = {
          opts = {
            show_presets = false,
            show_model_choices = true,
            -- allow_insecure = true,
            -- proxy = "http://127.0.0.1:8080",
          },
          tavily = function ()
            return require("codecompanion.adapters").extend("tavily", {
              env = {
                api_key = "cmd:secret-tool lookup password TAVILY_API_KEY ",
              },
            })
          end,
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:secret-tool lookup password antropic",
              },
            })
          end,

          mistral = function()
            return require("codecompanion.adapters.http").extend("mistral", {
              env = {
                api_key = "cmd:secret-tool lookup password MISTRAL_API_KEY",
              },
            })
          end,
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "cmd:secret-tool lookup password GEMINI_API_KEY",
              },
            })
          end,
          ollama = "ollama",
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              -- schema = {
              --   model = {
              --     default = "gpt-4.1",
              --   },
              -- },
              env = {
                api_key = "cmd:secret-tool lookup password OPENAI_API_KEY",
              },
            })
          end,
        }
      },
      extensions = {
        spinner = {},
        -- reasoning = {
        --   callback = 'codecompanion._extensions.reasoning', opts = { enabled = true }
        -- },
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 365,
            -- Picker interface (auto resolved to a valid picker)
            picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              ---Adapter for generating titles (defaults to current chat adapter)
              adapter = nil, -- "copilot"
              ---Model for generating titles (defaults to current chat model)
              model = nil, -- "gpt-4o"
              ---Number of user prompts after which to refresh the title (0 to disable)
              refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
              ---Maximum number of times to refresh the title (default: 3)
              max_refreshes = 3,
            },
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,
            -- Summary system
            summary = {
              -- Keymap to generate summary for current chat (default: "gcs")
              create_summary_keymap = "gcs",
              -- Keymap to browse summaries (default: "gbs")
              browse_summaries_keymap = "gbs",

              generation_opts = {
                adapter = nil, -- defaults to current chat adapter
                model = nil, -- defaults to current chat model
                context_size = 90000, -- max tokens that the model supports
                include_references = true, -- include slash command content
                include_tool_outputs = true, -- include tool execution results
                system_prompt = nil, -- custom system prompt (string or function)
                -- custom function to format generated summary e.g to remove <think/> tags from summary
                format_summary = nil,
                    },
                },

                -- Memory system (requires VectorCode CLI)
                memory = {
                    -- Automatically index summaries when they are generated
                    auto_create_memories_on_summary_generation = true,
                    -- Path to the VectorCode executable
                    vectorcode_exe = "vectorcode",
                    -- Tool configuration
                    tool_opts = {
                        -- Default number of memories to retrieve
                        default_num = 10
                    },
                    -- Enable notifications for indexing progress
                    notify = false,
                    -- Index all existing memories on startup
                    -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
                    index_on_startup = true,
                },
          }
        },
        -- TODO enable again when it support code 1.18
        -- vectorcode = {
        --   opts = {
        --     add_tool = true,
        --     add_slash_command = true,
        --   },
        -- },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true,  -- Show mcp tool results in chat
            make_vars = true,            -- Convert resources to #variables
            make_slash_commands = true,  -- Add prompts as /slash commands
          }
        }
      }
    },
  },{
    "Davidyz/VectorCode",
    -- version = "*",
    enabled = false , -- TODO enable again when it support code 1.18
    build = "uv tool upgrade vectorcode",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "VectorCode",
    },
    config = function()
      require("vectorcode").setup({
        cli_cmds = {
          vectorcode = "vectorcode",
        },
        ---@type VectorCode.RegisterOpts
        async_opts = {
          debounce = 10,
          events = { "BufWritePost", "InsertEnter", "BufReadPost" },
          exclude_this = true,
          n_query = 1,
          notify = false,
          query_cb = require("vectorcode.utils").make_surrounding_lines_cb(-1),
          run_on_register = true ,
        },
        async_backend = "lsp",--- "default", -- or "lsp"
        exclude_this = true,
        n_query = 1,
        notify = true,
        timeout_ms = 5000,
        on_setup = {
          update = true, -- set to true to enable update when `setup` is called.
          lsp = false,
        },
        sync_log_env_var = false
      })
      end
  }, {
    -- Make sure to set this up properly if you have lazy=true
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      completions = { blink = { enabled = true } },
      lsp = { enabled = false },
      file_types = { "markdown", "codecompanion" },
    },
    ft = { "markdown", "codecompanion" },
  },
{
{
  "github/copilot.vim",
  cmd = "Copilot",
  event = "BufWinEnter",
  enabled = false,
  init = function()
    vim.g.copilot_no_maps = true
  end,
  config = function()
    -- Block the normal Copilot suggestions
    vim.api.nvim_create_augroup("github_copilot", { clear = true })
    vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
      group = "github_copilot",
      callback = function(args)
        vim.fn["copilot#On" .. args.event]()
      end,
    })
    vim.fn["copilot#OnFileType"]()
  end,
},
{
  "saghen/blink.cmp",
  dependencies = { "fang2hou/blink-copilot" },
  events = {"VeryLazy"},
  opts = {
    sources = {
      -- default = { "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  },
}
},
{
  "HakonHarnes/img-clip.nvim",
  lazy = true,
  opts = {
    filetypes = {
      codecompanion = {
        prompt_for_file_name = false,
        template = "[Image]($FILE_PATH)",
        use_absolute_path = true,
      },
    },
  },
},
}
