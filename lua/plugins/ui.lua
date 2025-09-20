return {
    ---@type LazyPluginSpec
    {
        'echasnovski/mini.align',
        version = false,
        event = 'VeryLazy',
        config = function()
            require('mini.align').setup()
        end,
    },
    ---@type LazyPluginSpec
    {
        'catppuccin/nvim',
        priority = 1000,
        lazy = false,
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
                auto_integrations = true,
                background = {
                    light = 'latte',
                    dark = 'mocha',
                },
                transparent_background = true,
                show_end_of_buffer = false,
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = 'dark',
                    percentage = 0.15,
                },
                no_italic = false,
                no_bold = false,
                styles = {
                    comments = { 'italic' },
                    conditionals = {},
                    functions = { 'italic' },
                },
            })

            vim.cmd.colorscheme('catppuccin')
        end,
    },

    -- filename
    {
        'b0o/incline.nvim',
        dependencies = { 'catppuccin/nvim', 'nvim-tree/nvim-web-devicons' },
        event = 'BufReadPre',
        priority = 1200,
        config = function()
            require('incline').setup({
                window = { margin = { vertical = 0, horizontal = 1 } },
                hide = {
                    cursorline = true,
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                    if vim.bo[props.buf].modified then
                        filename = '[+] ' .. filename
                    end

                    local icon, color = require('nvim-web-devicons').get_icon_color(filename)
                    return { { icon, guifg = color }, { ' ' }, { filename } }
                end,
            })
        end,
    },
    ---@type LazyPluginSpec
    {
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
                disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
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
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = function() return { fg = require('snacks').util.color("Special") } end,
                    },
                    {
                        'diff',
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict

                            symbols = {
                                added = ' ',
                                modified = ' ',
                                removed = ' ',
                            }

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
    },
    ---@type LazyPluginSpec
    {
        'NvChad/nvim-colorizer.lua',
        event = 'BufReadPre',
        opts = {
            filetypes = { 'javascript', 'typescript', 'html', 'css', 'scss', '!lazy', '!prompt', '!nofile' },
            buftype = { 'javascript', 'typescript', 'html', 'css', 'scss' },
        },
    },
    ---@type LazyPluginSpec
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        config = function()
            require('noice').setup({
                lsp = {
                    progress = { enabled = false },
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true,
                    },
                },
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = true, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
            })
        end,
    },
    ---@type LazyPluginSpec
    {
        {
            'SmiteshP/nvim-navic',
            lazy = true,
            opts = function()
                local icons = require('custom.icons')
                return {
                    separator = ' ',
                    highlight = true,
                    depth_limit = 5,
                    icons = icons.kinds,
                    lazy_update_context = true,
                }
            end,
        },
        -- lualine integration
        {
            'nvim-lualine/lualine.nvim',
            optional = true,
            opts = function(_, opts)
                if not vim.g.trouble_lualine then
                    table.insert(opts.sections.lualine_c, { 'navic', color_correction = 'dynamic' })
                end
            end,
        },
    },
    ---@type LazyPluginSpec
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
    },
    ---@type LazyPluginSpec
    {
        'chrisgrieser/nvim-origami',
        event = 'VeryLazy',
        keys = {
            {
                '<LEFT>',
                function()
                    require('origami').h()
                end,
            },
            {
                '<RIGHT>',
                function()
                    require('origami').l()
                end,
            },
        },
        opts = {}, -- needed even when using default config
        init = function()
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
    },
}
