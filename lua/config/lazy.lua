-- https://github.com/folke/lazy.nvim
require('lazy').setup({
    spec = {
        { 'folke/LazyVim', import = 'lazyvim.plugins' },
        { import = 'lazyvim.plugins.extras.lang.typescript' },
    },
    defaults = { lazy = true },
    install = {
        missing = true,
        colorscheme = { 'tokyonight', 'gruvbox' },
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
