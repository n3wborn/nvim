local add_on_event = require('vim-pack').add_on_event

-- Indent guides.
add_on_event('BufWinEnter', {
    {
        src = 'saghen/blink.indent',
        opts = {
            blocked = { buftypes = { include_defaults = true }, filetypes = { include_defaults = true } },
            scope = {
                char = '▏',
                enabled = true,
                indent_at_cursor = false,
                priority = 1000,
                underline = { enabled = true },
            },
            static = {
                char = '▏',
                enabled = true,
            },
        },
    },
})
