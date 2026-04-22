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
    -- filename
    {
        'b0o/incline.nvim',
        dependencies = {
            'catppuccin/nvim',
            'nvim-mini/mini.icons',
        },
        event = 'BufReadPre',
        priority = 999,
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
        'brenoprata10/nvim-highlight-colors',
        cmd = {
            'HighlightColors',
        },
        event = 'VeryLazy',
        opts = {
            render = 'background', --'background'|'foreground'|'virtual'
            enable_hex = true,
            enable_short_hex = true,
            enable_rgb = true,
            enable_hsl = true,
            enable_ansi = true,
            enable_xterm256 = true,
            enable_xtermTrueColor = true,
            enable_hsl_without_function = true,
            enable_var_usage = true,
            enable_named_colors = true,
            enable_tailwind = true,
            exclude_filetypes = {
                'fzf',
                'help',
                'lazy',
                'markdown',
                'NeogitStashView',
                'NeogitStatus',
                'oil',
                'snacks_dashboard',
                'git',
            },
            exclude_buftypes = {},
            exclude_buffer = function(bufnr)
                return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000
            end,
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
