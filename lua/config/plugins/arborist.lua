vim.g.arborist_loaded = true -- skip auto-setup, we're configuring manually
local opts = {
    update_cadence = 'daily',
    overrides = {
        my_language = { url = 'https://github.com/me/tree-sitter-my-language' },
    },
}

require('arborist').setup(opts)
