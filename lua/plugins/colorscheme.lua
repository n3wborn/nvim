return {
    {
        'marko-cerovac/material.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            local material = require('material')
            vim.g.material_style = 'palenight'

            material.setup({
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
        end,

    },
}
