return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'enter' },
        signature = {
            appearance = {
                window = { border = vim.o.winborder },
            },
            appearance = {
                nerd_font_variant = 'mono',
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    menu = { border = vim.o.winborder },
                    window = { border = vim.o.winborder },
                },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = false,
                    },
                },
                menu = {
                    draw = {
                        columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            opts_extend = { 'sources.default' },
        },
    },
}
