local add_on_file_type = require('vim-pack').add_on_file_type

-- The blink.cmp source is configured in lua/plugin/blink.lua.
add_on_file_type('lua', {
    {
        src = 'folke/lazydev.nvim',
        opts = {
            library = {
                { path = 'snacks.nvim', words = { 'Snacks' } },
                { path = 'nvim-lspconfig', words = { 'lspconfig' } },
                { path = 'celeste_comment.nvim', words = { 'Celeste' } },
            },
        },
    },
})
