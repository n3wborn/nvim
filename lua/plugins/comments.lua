return {
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = function()
            require('Comment').setup({
                mappings = {
                    basic = false,
                    extra = false,
                },
            })

            vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)')
            vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_blockwise_visual)')
        end,
    },
}
