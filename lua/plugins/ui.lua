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
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {},
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'lsp_status' },
                lualine_y = { 'encoding', 'fileformat', 'filetype' },
                lualine_z = {},
            },
            inactive_sections = {},
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
