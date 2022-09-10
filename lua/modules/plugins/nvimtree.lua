-- https://github.com/kyazdani42/nvim-tree.lua
local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')

if not nvim_tree_ok then
    print('Something went wrong with', nvim_tree)
    return
else
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
        auto_reload_on_write = true,
        renderer = {
            indent_markers = {
                enable = true,
                inline_arrows = true,
            },
        },
    }

    -- setup
    nvim_tree.setup(config)

    -- mappings
    local u = require('utils')
    u.map('n', '<leader>e', ':NvimTreeToggle<CR>')
end
