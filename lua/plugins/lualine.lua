local M = {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
}

local function clock()
    return ' ' .. os.date('%H:%M')
end

function M.config()
    require('lualine').setup({
        options = {
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            icons_enabled = true,
            globalstatus = true,
            disabled_filetypes = { statusline = { 'dashboard', 'lazy' } },
        },
        sections = {
            lualine_a = { { 'mode', separator = { left = '' } } },
            lualine_b = { 'branch', 'diff' },
            lualine_c = {
                { 'diagnostics', sources = { 'nvim_diagnostic' } },
                { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                { 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
                {
                    function()
                        local navic = require('nvim-navic')
                        local ret = navic.get_location()
                        return ret:len() > 2000 and 'navic error' or ret
                    end,
                    cond = function()
                        if package.loaded['nvim-navic'] then
                            local navic = require('nvim-navic')
                            return navic.is_available()
                        end
                    end,
                },
            },
            lualine_x = {
                {
                    function()
                        return require('noice').api.status.command.get()
                    end,
                    cond = function()
                        if package.loaded['noice'] then
                            return require('noice').api.status.command.has()
                        end
                    end,
                    color = { fg = '#ff9e64' },
                },
                {
                    function()
                        return require('noice').api.status.mode.get()
                    end,
                    cond = function()
                        if package.loaded['noice'] then
                            return require('noice').api.status.mode.has()
                        end
                    end,
                    color = { fg = '#ff9e64' },
                },
                {
                    function()
                        return require('noice').api.status.search.get()
                    end,
                    cond = function()
                        if package.loaded['noice'] then
                            return require('noice').api.status.search.has()
                        end
                    end,
                    color = { fg = '#ff9e64' },
                },
                {
                    function()
                        return require('lazy.status').updates()
                    end,
                    cond = require('lazy.status').has_updates,
                    color = { fg = '#ff9e64' },
                },
                {
                    function()
                        local stats = require('lazy').stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return ' ' .. ms .. 'ms'
                    end,
                    color = { fg = '#ff9e64' },
                },
                -- function()
                --   return require("messages.view").status
                -- end,
                {
                    function()
                        return require('util.dashboard').status()
                    end,
                },
            },
            lualine_y = { 'location' },
            lualine_z = { { clock, separator = { right = '' } } },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        -- winbar = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = { "filename" },
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {},
        -- },
        --
        -- inactive_winbar = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = { "filename" },
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {},
        -- },
        extensions = { 'nvim-tree' },
    })
end

return M
