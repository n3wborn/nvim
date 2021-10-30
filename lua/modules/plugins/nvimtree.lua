-- https://github.com/kyazdani42/nvim-tree.lua

require('nvim-tree').setup({
    auto_close = true,
    hijack_cursor = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    filters = {
        dotfiles = false,
        custom = { 'node_modules', '.cache', 'build', 'var', 'vendor' },
    },
})

local u = require('utils')

u.map('n', '<leader>e', [[<cmd>lua require('nvim-tree').toggle()<cr>]])
u.map('n', '<leader>tr', [[<cmd>lua require('nvim-tree').refresh()<cr>]])
