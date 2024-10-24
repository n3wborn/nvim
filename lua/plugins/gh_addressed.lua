return {
    'dlvhdr/gh-addressed.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'folke/trouble.nvim',
    },
    cmd = 'GhReviewComments',
    keys = {
        { '<leader>gC', '<cmd>GhReviewComments<cr>', desc = 'GitHub Review Comments' },
    },
}
