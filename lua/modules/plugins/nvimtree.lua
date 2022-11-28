-- https://github.com/kyazdani42/nvim-tree.lua
local u = require('utils')
local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')

if not nvim_tree_ok then
    u.notif('Plugins :', 'Something went wrong with nvim-tree', vim.log.levels.WARN)
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
    u.map('n', '<leader>e', ':NvimTreeToggle<CR>')

    vim.api.nvim_create_autocmd('BufEnter', {
        desc = 'Quit nvim if nvim-tree is the last buffer',
        command = 'if winnr("$") == 1 && bufname() == "NvimTree_" . tabpagenr() | quit | endif',
        group = vim.api.nvim_create_augroup('nvim-tree', { clear = false }),
    })
end
