local add = require('vim-pack').add

add({
    {
        src = 'MagicDuck/grug-far.nvim',
        opts = {},
        on_setup = function()
            vim.keymap.set({ 'n', 'x' }, '<leader>rs', function()
                require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })
            end, { desc = ' Search and Replace' })
        end,
    },
})
