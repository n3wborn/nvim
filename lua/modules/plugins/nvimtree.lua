-- https://github.com/kyazdani42/nvim-tree.lua
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }

require('nvim-tree').setup({
    auto_close = true,
    hijack_cursor = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
})

local u = require('utils')

u.map('n', '<leader>e', [[<cmd>lua require('nvim-tree').toggle()<cr>]])
u.map('n', '<leader>tr', [[<cmd>lua require('nvim-tree').refresh()<cr>]])
