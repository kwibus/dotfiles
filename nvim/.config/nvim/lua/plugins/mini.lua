return {
    'echasnovski/mini.nvim',
    version = false,
    init = function ()
        require('mini.ai').setup() -- add text object argument a, function a
        require('mini.move').setup() -- move blocks with alt - <h,j,k,l>
        require('mini.align').setup()     -- align text with ga, gA
        require('mini.animate').setup({
            scroll = {
                enable = false
            },
            resize = {
                enable = false
            },
            open = {
                enable = false
            },
            close= {
                enable = false
            }
        })   -- animated mouse movement
        require('mini.cursorword').setup() -- works better https://github.com/ya2s/nvim-cursorline
        require('mini.splitjoin').setup() -- enable split join Toggle gS
        require('mini.surround').setup() -- surround add, sa,replace sr, delete sd highlight sh
        require('mini.operators').setup() -- evaluate selected as Lua : e=, exchange: gx, multiply text: gm, sort: gs, replace with reg: gr
        require('mini.trailspace').setup() -- add command  MiniTrailspace.trim()
        vim.g.minitrailspace_disable = true
        vim.api.nvim_create_user_command(
            "StripTrailingWhitespaces",
            function ()
                MiniTrailspace.trim()
            end,
            {desc="Strip trailing whitespace"}
        )
        require('mini.jump').setup() -- replace clever f
        -- require('mini.jump2d').setup()
        -- require('mini.sessions').setup( {
        --     autowrite = true,
        --     autoread = true,
        --     --directory = "sessions",
        --     verbose = {
        --         read = true ,
        --         write = true,
        --         delete = true
        --     },
        -- })
        -- vim.api.nvim_create_autocmd({"BufEnter"},{ callback = MiniSessions.read })

        -- could replace plugins/indent-blankline.lua
        require('mini.indentscope').setup()
        -- disable drawing but still useful for mapping
        vim.g.miniindentscope_disable = true
        require('mini.bracketed').setup()
    end,
}
