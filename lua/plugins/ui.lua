return {
    ---@type LazyPluginSpec
    {
        'nvim-mini/mini.align',
        version = false,
        event = 'VeryLazy',
        opts = {
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                start = 'ga',
                start_with_preview = 'gA',
            },
            -- Modifiers changing alignment steps and/or options
            modifiers = {
                -- Main option modifiers
                -- ['s'] = --<function: enter split pattern>,
                -- ['j'] = --<function: choose justify side>,
                -- ['m'] = --<function: enter merge delimiter>,

                -- Modifiers adding pre-steps
                -- ['f'] = --<function: filter parts by entering Lua expression>,
                -- ['i'] = --<function: ignore some split matches>,
                -- ['p'] = --<function: pair parts>,
                -- ['t'] = --<function: trim parts>,

                -- Delete some last pre-step
                -- ['<BS>'] = --<function: delete some last pre-step>,

                -- Special configurations for common splits
                -- ['='] = --<function: enhanced setup for '='>,
                -- [','] = --<function: enhanced setup for ','>,
                -- ['|'] = --<function: enhanced setup for '|'>,
                -- [' '] = --<function: enhanced setup for ' '>,
            },
            options = {
                split_pattern = '',
                justify_side = 'left',
                merge_delimiter = '',
            },

            -- Default steps performing alignment (if `nil`, default is used)
            steps = {
                pre_split = {},
                split = nil,
                pre_justify = {},
                justify = nil,
                pre_merge = {},
                merge = nil,
            },

            -- Whether to disable showing non-error feedback
            -- This also affects (purely informational) helper messages shown after
            -- idle time if user input is required.
            silent = false,
        },
        config = function(_, opts)
            require('mini.align').setup(opts)
        end,
    },
    ---@type LazyPluginSpec
    {
        'catppuccin/nvim',
        priority = 1000,
        lazy = false,
        name = 'catppuccin',
        ---@type CatppuccinOptions
        opts = {
            integrations = {
                fzf = true,
                diffview = true,
                rainbow_delimiters = true,
                gitsigns = true,
                noice = true,
            },
            flavour = 'mocha',
            transparent_background = true,
            lsp_styles = {
                virtual_text = {
                    errors = { 'italic' },
                    hints = { 'italic' },
                    warnings = { 'italic' },
                    information = { 'italic' },
                    ok = { 'italic' },
                },
                underlines = {
                    errors = { 'undercurl' },
                    hints = { 'undercurl' },
                    warnings = { 'undercurl' },
                    information = { 'undercurl' },
                },
                inlay_hints = {
                    background = true,
                },
            },
            styles = {
                functions = { 'italic' },
            },
            auto_integrations = true,
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)

            vim.cmd.colorscheme('catppuccin')
        end,
    },

    -- filename
    {
        'b0o/incline.nvim',
        dependencies = {
            'catppuccin/nvim',
            'nvim-mini/mini.icons',
        },
        event = 'BufReadPre',
        priority = 1200,
        config = function()
            require('incline').setup({
                window = { margin = { vertical = 0, horizontal = 1 } },
                hide = {
                    cursorline = true,
                },
            })
        end,
    },
    ---@type LazyPluginSpec
    {
        'NvChad/nvim-colorizer.lua',
        event = 'BufReadPre',
        opts = {
            {
                user_default_options = { names = true },
                filetypes = { 'javascript', 'typescript', 'html', 'css', 'scss', '!lazy', '!prompt', '!nofile' },
                buftype = { 'javascript', 'typescript', 'html', 'css', 'scss' },
            },
        },
    },
    ---@type LazyPluginSpec
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        ---@type NoiceConfig
        opts = {
            messages = { enabled = true },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
    },
    ---@type LazyPluginSpec
    {
        'SmiteshP/nvim-navic',
        lazy = true,
        opts = {
            separator = ' ',
            highlight = true,
            depth_limit = 5,
            lazy_update_context = true,
            lsp = {
                auto_attach = true,
                preference = { 'tsgo', 'typescript-tools' },
            },
        },
    },
    {
        'nvim-zh/colorful-winsep.nvim',
        event = { 'WinLeave' },
        opts = {
            border = 'rounded',
            excluded_ft = { 'lazy', 'packer', 'TelescopePrompt', 'mason' },
            animate = {
                enabled = 'shift',
                shift = {
                    delta_time = 0.2,
                    smooth_speed = 2,
                    delay = 3,
                },
            },
        },
    },
}
