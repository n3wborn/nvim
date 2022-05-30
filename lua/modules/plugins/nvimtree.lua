-- https://github.com/kyazdani42/nvim-tree.lua

-- config
local config = {
    filters = {
        dotfiles = false,
        custom = { 'node_modules', '.cache', 'build', 'var', 'vendor' },
    },
    view = {
        width = 35,
        height = 35,
    },
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },
    diagnostics = {
        icons = {
            error = '✗',
            warning = '!',
            info = '',
            hint = '',
        },
    },
    reload_on_bufenter = true,
}

-- setup
require('nvim-tree').setup(config)

-- mappings
local u = require('utils')
u.map('n', '<leader>e', ':NvimTreeToggle<CR>')
