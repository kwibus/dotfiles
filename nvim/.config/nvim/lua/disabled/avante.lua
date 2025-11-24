return {
  -- cursor ai for vim
  -- generate code for you
  "yetone/avante.nvim",
  event = "VeryLazy",
  cmd = "AvanteAsk",
  keys =  {
    "<leader>a"
  },
  version = false,
  enabled = false,
  opts = {
    debug = true,
    selector = {
      provider = "snacks",
    },
    rag_service = {
      enabled = true, -- Enables the RAG service
      host_mount = os.getenv("HOME"), -- Host mount path for the rag service
      runner = "docker",
      llm = {
        provider = "ollama", -- The provider to use for RAG service (e.g. openai or ollama)
        api_key = "",
        endpoint = "http://localhost:11434", -- The API endpoint for RAG service
      },
      embed = {
        provider = "ollma",
        api_key = "",
        endpoint = "http://localhost:11434", -- The API endpoint for RAG service
      }
    },
    -- provider = "ollama",
    -- -@type AvanteProvider
    -- use_absolute_path = true,
    -- add any opts here
    -- for example

    -- provider = "lmstudio",
    -- provider = "claude",
    -- provider = "ollama",
    provider = "mistral",
    providers = {
      mistral = {
        __inherited_from = "openai",
        -- api_key_name = "MISTRAL_API_KEY",
        api_key_name = "cmd:secret-tool lookup password MISTRAL_API_KEY",
        endpoint = "https://api.mistral.ai/v1/",
        model = "mistral-medium-latest",
        extra_request_body = {
          max_tokens = 4096, -- to avoid using max_completion_tokens
        },
      },
      claude = {
          api_key_name = "cmd:secret-tool lookup password antropic",
      },
      ollama = {
        endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
        model = "llama3.1:latest",
      },
      vendors = {
        lmstudio = {
            __inherited_from = "openai",
            api_key_name = "",
            endpoint = "http://127.0.0.1:1234/v1/",
            model = "qwen2.5-7b-instruct-1m", -- your desired model (or use gpt-4o, etc.)
            -- timeout = 30000, -- timeout in milliseconds
            -- temperature = 0, -- adjust if needed
            max_tokens = 4096,
            -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
        },

        -- provider = "ollama",
        -- ollama = {
        --     __inherited_from = "openai",
        --     api_key_name = "",
        --     endpoint = "http://127.0.0.1:11434/v1",
        --     model = "codegemma:2b-code",
        --     disable_tools = true, -- disable tools!
        -- },
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    -- "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
    -- "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy", -- do no load if avante is not loaded
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
