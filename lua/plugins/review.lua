---@type LazyPluginSpec
return {
    'vuki656/review.nvim',
    cmd = 'Review',
    keys = {
        {
            '<leader>rv',
            '<cmd>Review<cr>',
            mode = { 'n', 'v' },
            desc = 'Start a review',
        },
    },
    opts = {},
}
