-- https://github.com/kyazdani42/nvim-tree.lua
return {
    'kyazdani42/nvim-tree.lua',
    keys = {
        { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTree' },
    },
    opts = {
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
    },
    config = function(_, opts)
        require('nvim-tree').setup(opts)
    end,
}
