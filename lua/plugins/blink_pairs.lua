---@type LazyPluginSpec
return {
    'saghen/blink.pairs',
    dependencies = {
        'saghen/blink.lib',
        'catppuccin/nvim',
    },
    build = function()
        require('blink.pairs').build():pwait(60000)
    end,
    event = { 'BufEnter', 'BufNewFile' },
    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
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
            -- requires require('vim._extui').enable({}), otherwise has no effect
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
}
