return {
    {
        'anuvyklack/windows.nvim',
        dependencies = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim',
        },

        opts = {
            autowidth = {
                enable = true,
            },
            ignore = {
                buftype = { 'quickfix' },
                filetype = { 'NvimTree', 'neo-tree', 'undotree', 'gundo' },
            },
            animation = {
                enable = true,
                duration = 300,
                fps = 30,
                easing = 'in_out_sine',
            },
        },
        config = function(_, opts)
            require('windows').setup(opts)

            local function cmd(command)
                return table.concat({ '<Cmd>', command, '<CR>' })
            end

            vim.keymap.set('n', '<C-w>z', cmd('WindowsMaximize'))
            vim.keymap.set('n', '<C-w>_', cmd('WindowsMaximizeVertically'))
            vim.keymap.set('n', '<C-w>|', cmd('WindowsMaximizeHorizontally'))
            vim.keymap.set('n', '<C-w>=', cmd('WindowsEqualize'))
        end,
    },
}
