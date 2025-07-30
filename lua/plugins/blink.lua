return {
    'saghen/blink.cmp',
    dependencies = {
        'Kaiser-Yang/blink-cmp-git',
        'disrupted/blink-cmp-conventional-commits',
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'enter' },
        signature = {
            appearance = {
                window = { border = vim.o.winborder },
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
                default = {
                    'lsp',
                    'buffer',
                    'path',
                    'snippets',
                    'conventional_commits',
                },
            },
            providers = {
                conventional_commits = {
                    name = 'Conventional Commits',
                    module = 'blink-cmp-conventional-commits',
                    enabled = function()
                        return vim.bo.filetype == 'gitcommit'
                    end,
                    ---@module 'blink-cmp-conventional-commits'
                    ---@type blink-cmp-conventional-commits.Options
                    opts = {}, -- none so far
                },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            opts_extend = { 'sources.default' },
        },
    },
}
