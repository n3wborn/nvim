---@type LazyPluginSpec
return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'catppuccin',
            globalstatus = vim.o.laststatus == 3,
            disabled_filetypes = {
                statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard', 'gitcommit' },
            },
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = { 'filename' },
            lualine_x = {
                require('snacks').profiler.status(),
                -- stylua: ignore
                {
                    function() return require("noice").api.status.command.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                    color = function() return { fg = require('snacks').util.color("Statement") } end,
                },
                -- stylua: ignore
                {
                    function() return require("noice").api.status.mode.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    color = function() return { fg = require('snacks').util.color("Constant") } end,
                },
                -- stylua: ignore
                {
                    function() return "  " .. require("dap").status() end,
                    cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                    color = function() return { fg = require('snacks').util.color("Debug") } end,
                },
                -- stylua: ignore
                {
                    function() return require('tinygit.statusline').fileState() end,
                    cond = function() return package.loaded["tinygit"] end,
                    color = function() return { fg = require('snacks').util.color('Special') } end,
                },
                -- stylua: ignore
                {
                    require('lazy.status').updates,
                    cond = require('lazy.status').has_updates,
                    color = function() return { fg = require('snacks').util.color('Special') } end,
                },
                {
                    'diff',
                    source = function()
                        local gitsigns = vim.b.gitsigns_status_dict

                        if gitsigns then
                            return {
                                added = gitsigns.added,
                                modified = gitsigns.changed,
                                removed = gitsigns.removed,
                            }
                        end
                    end,
                },
            },
            lualine_y = {
                { 'progress', separator = ' ', padding = { left = 1, right = 1 } },
            },
            lualine_z = { 'encoding', 'fileformat', 'filetype' },
        },
        extensions = { 'neo-tree', 'lazy', 'fzf' },
    },
}
