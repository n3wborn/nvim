return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        cmd = 'LazyDev',
        dependencies = { 'DrKJeff16/wezterm-types' },
        opts = {
            library = {
                { path = 'snacks.nvim', words = { 'Snacks' } },
                { path = 'wezterm-types', mods = { 'wezterm' } },
                'lazy.nvim',
            },
        },
    },
}
