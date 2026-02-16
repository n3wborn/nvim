---@type LazyPluginSpec
return {
    'NeogitOrg/neogit',
    cmd = { 'Neogit' },
    keys = {
        { '<space>G', ':Neogit<CR>', desc = 'Open Neogit' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'folke/snacks.nvim',
    },
    opts = {
        graph_style = 'kitty',
        -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
        integrations = {
            codediff = false,
            telescope = false,
            fzf_lua = false,
            mini_pick = false,
            diffview = true,
            snacks = true,
        },
    },
}
