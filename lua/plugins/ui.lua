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
    {
        'akinsho/bufferline.nvim',
        event = 'VeryLazy',
        keys = {
            { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next tab' },
            { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev tab' },
        },
        opts = {
            options = {
                mode = 'tabs',
                -- separator_style = "slant",
                show_buffer_close_icons = false,
                show_close_icon = false,
            },
        },
    },

    ---@type LazyPluginSpec
    {
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
                    theme = 'catppuccin',
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
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
            }
        end,
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
        'SmiteshP/nvim-navic',
        dependencies = 'neovim/nvim-lspconfig',
        opts = {
            lsp = {
                auto_attach = true,
                preference = nil,
            },
            highlight = true,
            separator = '❯ ',
            depth_limit = 0,
            depth_limit_indicator = '..',
            safe_output = true,
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
