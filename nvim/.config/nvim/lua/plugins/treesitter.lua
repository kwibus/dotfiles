return {
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      branch = 'main',
      build = ':TSUpdate',
      init = function()
          local treesitter = require('nvim-treesitter')
          local filetypes = {
                "c",
                "cmake",
                "comment",
                "cpp",
                "css,",
                "csv",
                "dap_repl",
                "desktop",
                "dockerfile",
                "dot",
                "go",
                "haskell",
                "hcl",
                "helm",
                "html",
                "hyprlang",
                "javascript",
                "jinja",
                "jinja_inline",
                "jq",
                "json",
                "json5",
                "latex",
                "lua",
                "lua_patters",
                "luadoc",
                "make",
                "markdown",
                "mermaid",
                "norg",
                "ocaml",
                "perl",
                "php",
                "php_doc",
                "python",
                "query",
                "regex",
                "rst",
                "ruby",
                "rust",
                "scss",
                "sql",
                "ssh_config",
                "svelte",
                "sway",
                "terraform",
                "tmux",
                "toml",
                "tsx",
                "typescript",
                "typst",
                "udev",
                "vim",
                "vimdoc",
                "vue",
                "xml",
                "yaml",
                "zathurarc",
                "zig",
            }
            treesitter.install(filetypes)
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                   if vim.list_contains(filetypes, vim.bo.filetype ) then
                       vim.treesitter.start()
                   end
                end,
            })

      end,
    },
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        enabled = false
    },
}
