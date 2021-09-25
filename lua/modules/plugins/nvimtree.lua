-- https://github.com/kyazdani42/nvim-tree.lua
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }

require('nvim-tree').setup({
    disable_netrw = true,
    ignore_ft_on_setup = { 'startify', 'dashboard' },
    auto_close = true,
    hijack_cursor = false,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
})
