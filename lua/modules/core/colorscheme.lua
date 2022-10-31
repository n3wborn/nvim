-- Colorscheme

-- https://github.com/marko-cerovac/material.nvim
vim.g.material_style = 'palenight'

require('material').setup({
    styles = {
        comments = { italic = true },
        functions = { italic = true },
    },
    contrast = {
        sidebars = true,
        floating_windows = false,
        cursor_line = true,
        popup_menu = false,
        filetypes = {
            'terminal',
            'packer',
            'qf',
        },
    },
    high_visibility = {
        lighter = false,
        darker = false,
    },
    disable = {
        background = true,
    },
    custom_highlights = {
        NormalNC = { bg = 'NONE' },
    },
    plugins = {
        'gitsigns',
        'nvim-cmp',
    },
})

vim.cmd([[colorscheme material]])
