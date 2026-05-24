---@type LazyPluginSpec
return {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    keys = {
        {
            '<leader><leader>r',
            function()
                require('kulala').run()
            end,
            mode = { 'n', 'v' }, -- optional mode, default is n
            desc = 'Send request', -- optional description, otherwise inferred from the key
        },
        {
            '<leader><leader>ra',
            function()
                require('kulala').run_all()
            end,
            mode = { 'n', 'v' }, -- optional mode, default is n
            desc = 'Send all request', -- optional description, otherwise inferred from the key
        },
    },
    opts = {
        kulala_keymaps_prefix = '',
        ui = {
            display_direction = 'horizontal',
        },

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
