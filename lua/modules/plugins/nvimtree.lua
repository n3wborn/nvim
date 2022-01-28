-- https://github.com/kyazdani42/nvim-tree.lua

-- config
local config = {
    -- open_on_setup = true,
    auto_close = true,
    filters = {
        dotfiles = false,
        custom = { 'node_modules', '.cache', 'build', 'var', 'vendor' },
    },
    view = {
        width = 35,
        height = 35,
    },
}

-- setup
require('nvim-tree').setup(config)

-- mappings
local u = require('utils')
u.map('n', '<leader>e', ':NvimTreeToggle<CR>')
u.map('n', '<leader>tr', ':NvimTreeRefresh<CR>')
