return {

    {
        'stevearc/oil.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = 'Oil',
        event = 'VeryLazy',
        config = function()
            require('oil').setup({
                columns = { 'icon' },
                keymaps = {
                    ['<C-h>'] = false,
                    ['<M-h>'] = 'actions.select_split',
                },
                view_options = {
                    show_hidden = true,
                },
            })

            -- Open parent directory in current window
            vim.keymap.set('n', '-', require('oil').open, { desc = 'Open parent directory' })

            -- Open parent directory in floating window
            vim.keymap.set('n', '<space>-', require('oil').toggle_float)
        end,
    },
    {
        'A7Lavinraj/fyler.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            icon_provider = 'nvim-web-devicons',
        },
        keys = {
            {
                '<leader>e',
                function()
                    local fyler = require('fyler')
                    fyler.open()
                end,
                desc = 'Fyler',
            },
        },
    },
}
