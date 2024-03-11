return {
    'bloznelis/before.nvim',
    config = function()
        local before = require('before')
        before.setup({ history_size = 42 })

        vim.keymap.set('n', '<C-j>', before.jump_to_last_edit, {})
        vim.keymap.set('n', '<C-k>', before.jump_to_next_edit, {})
    end,
}
