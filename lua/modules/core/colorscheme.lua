-- Colorscheme

-- https://github.com/marko-cerovac/material.nvim
vim.g.material_style = 'palenight'

require('material').setup({
    contrast = false,
    italics = {
        comments = true,
        functions = true,
    },
    contrast_windows = {
        'terminal',
        'packer',
        'qf',
    },
    text_contrast = {
        lighter = false,
        darker = false,
    },
    disable = {
        background = true,
    },
})

vim.cmd([[colorscheme material]])
