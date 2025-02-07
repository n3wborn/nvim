return {
    'SmiteshP/nvim-navbuddy',
    cmd = 'Navbuddy',
    keys = {
        { '<leader>N', '<cmd>Navbuddy<cr>', desc = 'nabuddy' },
    },
    dependencies = {
        'SmiteshP/nvim-navic',
        'MunifTanjim/nui.nvim',
    },
    opts = { lsp = { auto_attach = true } },
}
