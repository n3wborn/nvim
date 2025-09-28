return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    enabled = not vim.g.nvim_cmp_enabled,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'enter',
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<Up'] = { 'select_prev', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab'] = { 'select_prev', 'fallback' },
        },

        completion = {
            menu = {
                draw = {
                    columns = {
                        { 'label', 'label_description', gap = 1 },
                        { 'kind_icon', gap = 1, 'kind' },
                    },
                },
            },
        },

        appearance = {
            nerd_font_variant = 'mono',
        },

        signature = { enabled = true },
    },
    -- opts_extend = { 'sources.default' },
}
