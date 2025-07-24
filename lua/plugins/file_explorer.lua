return {
    {
        'A7Lavinraj/fyler.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = { 'Fyler' },
        opts = {
            icon_provider = 'nvim-web-devicons',
        },
        keys = {
            { '<leader>e', '<cmd>Fyler open<cr>', desc = 'Fyler' },
        },
    },
}
