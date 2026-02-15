return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        cmd = 'LazyDev',
        opts = {
            library = {
                { path = 'snacks.nvim', words = { 'Snacks' } },
                'lazy.nvim',
            },
        },
    },
}
