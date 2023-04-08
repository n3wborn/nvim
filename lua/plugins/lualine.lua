return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    opts = function()
        local navic = require('nvim-navic')
        local config = {
            options = {
                icons_enabled = true,
                theme = 'catpuccin',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename', { navic.get_location, cond = navic.is_available } },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = {},
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                -- lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
        }
    end,
    config = function(_, opts)
        require('lualine').setup(opts)
    end,
}
