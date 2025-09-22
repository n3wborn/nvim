---@type LazyPluginSpec
return {
    'zerochae/endpoint.nvim',
    dependencies = {
        'folke/snacks.nvim',
    },
    lazy = true,
    cmd = { 'Endpoint' },
    keys = {
        { '<space>E', '<cmd>Endpoint<cr>', desc = 'Find API endpoints' },
        { '<space>Eg', '<cmd>Endpoint Get<cr>', desc = 'Find GET endpoints' },
        { '<space>Ep', '<cmd>Endpoint Post<cr>', desc = 'Find POST endpoints' },
        { '<space>Ed', '<cmd>Endpoint Delete<cr>', desc = 'Find DELETE endpoints' },
    },
    opts = {
        cache = {
            mode = 'none',
        },
        picker = {
            type = 'snacks',
            options = {
                snacks = { preview = 'file' },
            },
        },
        ui = {
            show_icons = false,
            show_method = true,
        },
    },
}
