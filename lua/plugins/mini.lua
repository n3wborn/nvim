return {
    ---@type LazyPluginSpec
    {
        'nvim-mini/mini.icons',
        opts = {},
    },
    ---@type LazyPluginSpec
    {
        'nvim-mini/mini.hipatterns',
        event = 'VeryLazy',
        opts = {
            highlighters = {
                -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
            },
        },
    },
    ---@type LazyPluginSpec
    {
        'nvim-mini/mini.clue',
        lazy = false,
        opts = function()
            local miniclue = require('mini.clue')

            return {

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
            }
        end,
    },
}
