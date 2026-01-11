return {
    {
        'nvim-mini/mini.pairs',
        version = false,
        event = 'VeryLazy',
        opts = {},
    },
    {
        'nvim-mini/mini.comment',
        version = '*',
        event = 'VeryLazy',
        opts = {
            options = {
                custom_commentstring = function()
                    return require('ts_context_commentstring.internal').calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
        },
    },
    ---@type LazyPluginSpec
    {
        'nvim-mini/mini.clue',
        version = false,
        lazy = false,
        config = function()
            local miniclue = require('mini.clue')

            miniclue.setup({

                triggers = {
                    -- Leader triggers
                    { mode = { 'n', 'x' }, keys = '<Leader>' },

                    -- `[` and `]` keys
                    { mode = 'n', keys = '[' },
                    { mode = 'n', keys = ']' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = { 'n', 'x' }, keys = 'g' },

                    -- Marks
                    { mode = { 'n', 'x' }, keys = "'" },
                    { mode = { 'n', 'x' }, keys = '`' },

                    -- Registers
                    { mode = { 'n', 'x' }, keys = '"' },
                    { mode = { 'i', 'c' }, keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = { 'n', 'x' }, keys = 'z' },
                },
                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.square_brackets(),
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
            })
        end,
    },
}
