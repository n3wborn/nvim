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
            ['<Tab>'] = { 'select_next' },
            ['<S-Tab'] = { 'select_prev' },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },

        signature = { enabled = true },
    },
    -- opts_extend = { 'sources.default' },
}
