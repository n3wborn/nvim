-- https://github.com/kyazdani42/nvim-tree.lua
return {
    'kyazdani42/nvim-tree.lua',
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
        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

        vim.api.nvim_create_autocmd('BufEnter', {
            desc = 'Quit nvim if nvim-tree is the last buffer',
            command = 'if winnr("$") == 1 && bufname() == "NvimTree_" . tabpagenr() | quit | endif',
            group = vim.api.nvim_create_augroup('nvim-tree', { clear = false }),
        })
    end,
}
