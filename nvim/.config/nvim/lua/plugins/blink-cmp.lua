return {
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {
      -- impersonate_nvim_cmp = true,
      -- debug = true,
    },
  },{
    'saghen/blink.cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'ribru17/blink-cmp-spell',
      "bydlw98/blink-cmp-env",
      'Kaiser-Yang/blink-cmp-git',
      'nvim-lua/plenary.nvim',
      'saghen/blink.compat',
      'andersevenrud/cmp-tmux',
      {'tamago324/cmp-zsh', ft = { 'zsh', 'sh', 'bash' }},
      -- 'supermaven-inc/supermaven-nvim',
    },
    version = '*',
    build = 'cargo build --release',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        -- :
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',
        -- conflict with my tmux vim/tmux key mapping but am used to.
        ['<C-h>'] = { 'cancel' },
        ['<C-l>'] = { 'select_and_accept' },
      },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        -- nerd_font_variant = 'mono'
      },
      cmdline = {
        enabled = true,
        keymap = { preset = 'inherit' }, -- Inherits from top level `keymap` config when not set
        completion = {
          menu = { auto_show = true },
          list = { selection = { preselect = false, auto_insert = true, } },
        },
      },
      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before _and_ after the cursor
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        keyword = { range = 'full' },
        list = { selection = { preselect = false, auto_insert = true, } },
        -- Disable auto brackets
        -- NOTE: some LSPs may add auto brackets themselves anyway
        accept = { auto_brackets = { enabled = false }, },
        documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = 'single' }  },
        --  ghost_text = { enabled = true, show_with_menu = true},
        menu = {
          border = 'single',
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_id", } },
            treesitter = { 'lsp' }
          }
        },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = {
          -- 'supermaven',
          'lsp',
          'path',
          'snippets',
          'buffer',
          'omni',
          'spell',
          'git',
          "env",
          "tmux"
        },
        per_filetype = {
          zsh = { 'zsh' },
          sh = { 'zsh' },
          bashsh = { 'zsh' },
        },
        providers = {
          supermaven = {
            -- IMPORTANT: use the same name as you would for nvim-cmp
            name = 'supermaven',
            module = 'blink.compat.source',
            score_offset = 100,
            async = true,
            min_keyword_length = 0,
            opts = { }
          },
          tmux= {
            name = 'tmux',
            module = 'blink.compat.source',
            score_offset = -10,
            async = true,
            opts = {

              -- Source from all panes in session instead of adjacent panes
              all_panes = true,
              -- Completion popup label
              label = '',

              -- Trigger character
              -- trigger_characters = { '.' },

              -- Specify trigger characters for filetype(s)
              -- { filetype = { '.' } }
              -- trigger_characters_ft = {},

              -- Keyword patch pattern
              -- keyword_pattern = [[\w\+]],

              -- Capture full pane history
              -- `false`: show completion suggestion from text in the visible pane (default)
              -- `true`: show completion suggestion from text starting from the beginning of the pane history.
              --         This works by passing `-S -` flag to `tmux capture-pane` command. See `man tmux` for details.
              capture_history = true,
            }
          },
          zsh = {
            name = 'zsh',
            module = 'blink.compat.source',
            opts = {}
          },
          env = {
            name = "Env",
            module = "blink-cmp-env",
            score_offset = -3,
            --- @type blink-cmp-env.Options
            opts = {
              -- item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
              show_braces = false,
              show_documentation_window = true,
            },
          },
          -- only enabled on filetype gitcommit and markdown when typing :
          git = {
            module = 'blink-cmp-git',
            name = 'Git',
            opts = {
              -- options for the blink-cmp-git
            },
          },
          spell = {
            name = 'Spell',
            module = 'blink-cmp-spell',
            opts = {
              -- EXAMPLE: Only enable source in `@spell` captures, and disable it
              -- in `@nospell` captures.
              enable_in_context = function()
                local curpos = vim.api.nvim_win_get_cursor(0)
                local captures = vim.treesitter.get_captures_at_pos(
                  0,
                  curpos[1] - 1,
                  curpos[2] - 1
                )
                local in_spell_capture = false
                for _, cap in ipairs(captures) do
                  if cap.capture == 'spell' then
                    in_spell_capture = true
                  elseif cap.capture == 'nospell' then
                    return false
                  end
                end
                return in_spell_capture
              end,
            },
          },
        }
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },

      -- Experimental signature help support
      signature = {
        enabled = true,
        window = { border = 'single' }
      },
    },
    opts_extend = { "sources.default" }
  },{
    "supermaven-inc/supermaven-nvim",
    enabled = false,
    event = "InsertEnter",
    config = function()
        require("supermaven-nvim").setup({
            -- keymaps = {
            --     accept_suggestion = "<C-l>",
            --     clear_suggestion = "<C-k>",
            --     accept_word = "<C-j>",
            -- },
            disable_inline_completion = true, -- disables inline completion for use with cmp
            disable_keymaps = true,
            color = {
                suggestion_color = "#3f3f3f",
                cterm = 244,
            },
        })
    end,
  },{
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*",   -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
    -- TODO configure key map next field
  }
}
