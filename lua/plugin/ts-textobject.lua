local add_on_event = require('vim-pack').add_on_event

-- Must be set before the plugin is loaded.
vim.g.no_plugin_maps = true

add_on_event({ 'BufReadPre', 'BufNewFile' }, {
    {
        src = 'nvim-treesitter/nvim-treesitter-textobjects',
        version = 'main',
        on_setup = function()
            require('config.textobjects_keymaps').setup()
        end,
    },
})
