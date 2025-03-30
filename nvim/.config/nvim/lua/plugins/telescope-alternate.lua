return {
    'otavioschwanck/telescope-alternate.nvim',
    keys = {
        { mode = 'n', '<leader>a', '<cmd>Telescope telescope-alternate alternate_file<cr>', desc = 'Alternate file' }
    },
    opts = {
        mappings = {
            { '([^/]*)/(.*).py',
                { 'tests/[2]_test.py', 'Test',}
            },
            { 'tests/(.*)_test.py',
                { '*/[1].py', 'Alternate' }
            },
            { '([^/]*)/(.*).py',
                { 'tests/test_[2].py', 'Test',}
            },
            { 'tests/test_(.*).py',
                { '*/[1].py', 'Alternate' }
            },
            { 'classes/(.*).php',
                { 'tests/[1]_test.php', 'Test', true }
            },
            { 'tests/(.*)_test.php',
                { 'classes/[1].php', 'Alternate' }
            },
            { '(.*).go',
                { '[1]_test.go', 'Test', true }
            },
            { '(.*)_test.go',
                { '[1].go', 'Alternate' }
            }
        }
    }
}
