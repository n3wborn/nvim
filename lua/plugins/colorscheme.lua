---@type LazyPluginSpec
return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
        compile = {
            enabled = true,
        },
        transparent_background = true,
        float = {
            transparent = false,
        },
        auto_integrations = false,
        integrations = {
            alpha = false,
            blink_cmp = {
                style = 'bordered',
            },
            blink_indent = true,
            blink_pairs = true,
            dashboard = false,
            diffview = true,
            flash = false,
            fzf = true,
            gitgraph = true,
            gitsigns = true,
            grug_far = true,
            indent_blankline = { enabled = false },
            mini = {
                enabled = true,
                indentscope_color = false,
            },
            cmp = false,
            neogit = true,
            dap = true,
            dap_ui = true,
            nvimtree = false,
            treesitter_context = true,
            ufo = false,
            rainbow_delimiters = false,
            snacks = {
                enabled = true,
                indent_scope_color = false,
            },
            telescope = { enabled = false },
            illuminate = { enabled = false },
        },
    },
}
