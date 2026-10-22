local add = require('vim-pack').add

add({
    {
        src = 'vuki656/review.nvim',
        opts = {},
        on_setup = function()
            vim.keymap.set({ 'n', 'v' }, '<leader>rv', '<cmd>Review<cr>', { desc = 'Start a review' })
        end,
    },
})
