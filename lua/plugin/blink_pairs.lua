local add_on_event = require('vim-pack').add_on_event

-- Auto-pairs and rainbow delimiters.
add_on_event({ 'BufEnter', 'BufNewFile' }, {
    { src = 'saghen/blink.lib', setup = false },
    {
        src = 'saghen/blink.pairs',
        opts = {
            mappings = {
                enabled = true,
                cmdline = true,
                -- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
                -- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
                disabled_filetypes = {},
                pairs = {},
            },
            highlights = {
                enabled = true,
                -- requires require('vim._core.ui2').enable() (see init.lua), otherwise has no effect
                cmdline = true,
                groups = {
                    'BlinkPairsPurple',
                    'BlinkPairsBlue',
                    'BlinkPairsOrange',
                },
                unmatched_group = 'BlinkPairsUnmatched',
                matchparen = {
                    enabled = true,
                    -- known issue where typing won't update matchparen highlight, disabled by default
                    cmdline = false,
                    -- also include pairs not on top of the cursor, but surrounding the cursor
                    include_surrounding = false,
                    group = 'BlinkPairsMatchParen',
                    priority = 250,
                },
            },
            debug = false,
        },
        on_setup = function()
            -- TODO: Fix the Task type below.
            require('blink.pairs').build():pwait(60000)
        end,
    },
})
