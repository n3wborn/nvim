local add_on_file_type = require('vim-pack').add_on_file_type

add_on_file_type('go', {
    {
        src = 'olexsmir/gopher.nvim',
        ---@module "gopher"
        ---@type gopher.Config
        opts = {},
    },
})
