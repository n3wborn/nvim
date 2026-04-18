---@type LazyPluginSpec
return {
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',
    opts = {
        library = {
            { path = 'snacks.nvim', words = { 'Snacks' } },
            -- 'lazy.nvim',
            { path = 'lazy.nvim', words = { 'Lazy' } },
        },
    },
}
