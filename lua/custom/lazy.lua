-- https://github.com/folke/lazy.nvim
require('lazy').setup({
    spec = {
        -- import LazyVim plugins
        -- { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
        -- import any extras modules here
        -- add typescript/json (https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins/extras/lang)
        -- { import = 'lazyvim.plugins.extras.lang.typescript' },
        -- { import = 'lazyvim.plugins.extras.lang.json' },
        -- import/override with your plugins
        { import = 'plugins' },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = {
        missing = true,
        colorscheme = { 'catpuccin' },
    },
    checker = { enabled = true }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
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
})
