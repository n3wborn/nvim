return {
    {

        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = false,
    },
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        opts = {
            toggler = {
                ---Line-comment toggle keymap
                line = '<C-_>',
                ---Block-comment toggle keymap
                -- block = '<C-_>',
            },
        },
        config = function(_, opts)
            require('Comment').setup(opts)
        end,
    },
}
