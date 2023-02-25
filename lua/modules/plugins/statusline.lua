-- statusline
-- https://github.com/nvim-lualine/lualine.nvim
local ok, lualine = pcall(require, 'lualine')
local navic_ok, navic = pcall(require, 'nvim-navic')
local u = require('utils')

if not ok then
    u.notif('Plugins :', 'Something went wrong with lualine', vim.log.levels.WARN)
    return
end

if not navic_ok then
    u.notif('Plugins :', 'Something went wrong with navic', vim.log.levels.WARN)
    return
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'filetype' },
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = { { navic.get_location, cond = navic.is_available } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        'quickfix',
        'nvim-tree',
    },
})
