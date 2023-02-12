-- https://github.com/marko-cerovac/material.nvim
local ok, material = pcall(require, 'material')
local u = require('utils')

if not ok then
    u.notif('Plugins :', 'Something went wrong with material', vim.log.levels.WARN)
    return
else
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
end
