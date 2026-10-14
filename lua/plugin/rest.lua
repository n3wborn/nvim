local add_on_file_type = require('vim-pack').add_on_file_type

-- Configured through vim.g.rest_nvim, the `http` treesitter parser is installed in lua/plugin/treesitter.lua.
add_on_file_type('http', {
    { src = 'rest-nvim/rest.nvim', setup = false },
})
