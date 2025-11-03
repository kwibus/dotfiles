return {
  -- cursor ai for vim
  -- generate code for you
  "yetone/avante.nvim",
  -- event = "VeryLazy",
  cmd = "AvanteAsk",
  keys =  {
    "<leader>a"
  },
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  enabled = false,
  opts = {
    -- debug = true,
    selector = {
      provider = "telescope",
    },
    rag_service = {
      enabled = true, -- Enables the RAG service
      host_mount = os.getenv("HOME"), -- Host mount path for the rag service
      provider = "ollama", -- The provider to use for RAG service (e.g. openai or ollama)
      llm_model = "", -- The LLM model to use for RAG service
      embed_model = "", -- The embedding model to use for RAG service
      endpoint = "http://localhost:11434", -- The API endpoint for RAG service
    },
    -- provider = "ollama",
    -- -@type AvanteProvider
    -- use_absolute_path = true,
    -- add any opts here
    -- for example

    provider = "ollama",
    -- provider = "lmstudio",
    -- provider = "claude",
    claude = {
        api_key_name = "cmd:secret-tool lookup password antropic",
    },
    ollama = {
      endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
      model = "qwen:7b",
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
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      -- event = "VeryLazy", -- do no load if avante is not loaded
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
