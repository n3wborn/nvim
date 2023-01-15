-- https://github.com/folke/lazy.nvim
require('lazy').setup({
    spec = {
        -- load lazyvim plugins
        { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
        -- add typescript/json (https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins/extras/lang)
        { import = 'lazyvim.plugins.extras.lang.typescript' },
        { import = 'lazyvim.plugins.extras.lang.json' },
        -- load local plugins dir
        { import = 'plugins' },
    },
    defaults = { lazy = true },
    install = {
        missing = true,
        colorscheme = { 'material' },
    },
    checker = { enabled = true },
    ui = {
        size = { width = 0.6, height = 0.6 },
        border = 'double',
    },
    diff = { cmd = 'git' },
    change_detection = {
        enabled = true,
        notify = true,
    },
    performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
    debug = false,
})
