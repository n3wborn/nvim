-- statusline

-- https://github.com/nvim-lualine/lualine.nvim
-- https://github.com/arkav/lualine-lsp-progress
require('lualine').setup({
    options = {
        theme = 'material-nvim',
    },
    extensions = {
        'quickfix',
        'nvim-tree',
    },
    sections = {
        lualine_c = {
            'lsp_progress',
        },
    },
})
