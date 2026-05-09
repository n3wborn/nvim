---@type LazyPluginSpec
return {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    opts = {
        -- your configuration comes here
        global_keymaps = {
            ['Send request'] = { -- sets global mapping
                '<space>Rs',
                function()
                    require('kulala').run()
                end,
                mode = { 'n', 'v' }, -- optional mode, default is n
                desc = 'Send request', -- optional description, otherwise inferred from the key
            },
            ['Send all requests'] = {
                '<space>Ra',
                function()
                    require('kulala').run_all()
                end,
                mode = { 'n', 'v' },
                ft = 'http', -- sets mapping for *.http files only
            },
            ['Replay the last request'] = {
                '<space>Rr',
                function()
                    require('kulala').replay()
                end,
                ft = { 'http', 'rest' }, -- sets mapping for specified file types
            },
            ['Find request'] = false, -- set to false to disable
        },
        global_keymaps_prefix = '<space>R',
        kulala_keymaps_prefix = '',
        syntax_hl = {
            ['@punctuation.bracket.kulala_http'] = 'Number',
            ['@character.special.kulala_http'] = 'Special',
            ['@operator.kulala_http'] = 'Special',
            ['@variable.kulala_http'] = 'String',
        },

        -- scratchpad default contents
        scratchpad_default_contents = {
            '@MY_TOKEN_NAME=my_token_value',
            '',
            '# @name scratchpad',
            'POST https://httpbin.org/post HTTP/1.1',
            'accept: application/json',
            'content-type: application/json',
            '',
            '{',
            '  "foo": "bar"',
            '}',
        },
    },
}
