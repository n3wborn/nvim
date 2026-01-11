return {
    src = 'https://github.com/mbbill/undotree',
    data = {
        setup = function()
            vim.keymap.set('n', '<leader>U', '<CMD>UndotreeToggle<CR>', { noremap = true, desc = 'Undotree' })
        end,
    },
}
