local add = require('vim-pack').add

-- Set before loading vim-dadbod-ui.
vim.g.db_ui_use_nerd_fonts = 1

-- The blink.cmp source for sql files is configured in lua/plugin/blink.lua.
add({
    { src = 'tpope/vim-dadbod', setup = false },
    { src = 'kristijanhusak/vim-dadbod-completion', setup = false },
    { src = 'kristijanhusak/vim-dadbod-ui', setup = false },
    {
        src = 'joryeugene/dadbod-grip.nvim',
        opts = {},
        on_setup = function()
            vim.keymap.set('n', '<leader>db', '<cmd>GripConnect<cr>', { desc = 'DB connect' })
            vim.keymap.set('n', '<leader>dg', '<cmd>Grip<cr>', { desc = 'DB grid' })
            vim.keymap.set('n', '<leader>dt', '<cmd>GripTables<cr>', { desc = 'DB tables' })
            vim.keymap.set('n', '<leader>dq', '<cmd>GripQuery<cr>', { desc = 'DB query pad' })
            vim.keymap.set('n', '<leader>ds', '<cmd>GripSchema<cr>', { desc = 'DB schema' })
            vim.keymap.set('n', '<leader>dh', '<cmd>GripHistory<cr>', { desc = 'DB history' })
        end,
    },
})
