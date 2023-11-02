return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
        indent = {
            char = '│',
        },
        scope = {
            show_start = false,
            show_end = false,
        },
    },
}
