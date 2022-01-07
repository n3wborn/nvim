-- Colorscheme

-- https://github.com/marko-cerovac/material.nvim
vim.g.material_style = 'palenight'

require('material').setup({
    italics = {
        comments = true,
        functions = true,
    },
    contrast_filetypes = {
        'terminal',
        'packer',
        'qf',
    },
    high_visibility = {
        lighter = false,
        darker = false,
    },
    disable = {
        background = true,
    },
})

vim.cmd([[colorscheme material]])
