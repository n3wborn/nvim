---@type LazyPluginSpec
return {
    'NeogitOrg/neogit',
    cmd = { 'Neogit' },
    keys = {
        { '<leader>gg', ':Neogit<CR>', desc = 'Open Neogit' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'dlyongemallo/diffview-plus.nvim',
    },
    opts = {
        graph_style = 'kitty',
        -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
        integrations = {
            codediff = false,
            telescope = false,
            fzf_lua = true,
            mini_pick = false,
            diffview = true,
            snacks = true,
        },
        diff_viewer = 'diffview',
        sections = {
            recent = {
                folded = false,
            },
        },
        signs = {
            -- { CLOSED, OPENED }
            hunk = { '', '' },
            item = { '', '' },
            section = { '', '' },
        },
    },
}
