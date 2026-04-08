vim.pack.add({
    'https://github.com/arborist-ts/arborist.nvim',
})

vim.g.arborist_loaded = true -- skip auto-setup, we're configuring manually
require('arborist').setup({
    update_cadence = 'daily',
    overrides = {
        my_language = { url = 'https://github.com/me/tree-sitter-my-language' },
    },
})
