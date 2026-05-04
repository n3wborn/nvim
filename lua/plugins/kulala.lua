---@type LazyPluginSpec
return {
    'mistweaverco/kulala.nvim',
    keys = {
        { '<space>Rs', desc = 'Send request' },
        { '<space>Ra', desc = 'Send all requests' },
        { '<space>Rb', desc = 'Open scratchpad' },
    },
    ft = { 'http', 'rest' },
    opts = {
        -- your configuration comes here
        global_keymaps = false,
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
