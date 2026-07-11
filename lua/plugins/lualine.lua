return {
    -- From BrendonJL/dotfiles
    ---@type LazyPluginSpec
    ---@diagnostic disable-next-line: assign-type-mismatch
    {
        'nvim-lualine/lualine.nvim',
        event = 'UIEnter',
        opts = function(_, opts)
            -- Custom components
            local icons = require('config.icons')

            opts.options = opts.options or {}
            opts.options.component_separators = { left = '│', right = '│' }
            opts.options.section_separators = { left = '', right = '' }
            opts.options.globalstatus = false -- default
            opts.options.refresh = {
                statusline = 200,
                refresh_time = 16, -- ~60fps
                events = {
                    'WinEnter',
                    'BufEnter',
                    'BufWritePost',
                    'SessionLoadPost',
                    'FileChangedShellPost',
                    'VimResized',
                    'Filetype',
                    'CursorMoved',
                    'CursorMovedI',
                    'ModeChanged',
                },
            }

            -- Left sections
            opts.sections = opts.sections or {}
            opts.sections.lualine_a = {}
            opts.sections.lualine_b = {
                {
                    'branch',
                    icon = icons.git.git,
                    padding = { left = 1, right = 1 },
                },
                {
                    'diff',
                    symbols = {
                        added = icons.git.added,
                        modified = icons.git.modified,
                        removed = icons.git.removed,
                    },
                    padding = { left = 1, right = 1 },
                },
            }
            opts.sections.lualine_c = {
                {
                    'diagnostics',
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    },
                },
                {
                    'filename',
                    path = 1,
                    symbols = {
                        modified = ' ',
                        readonly = '[Readonly]',
                        unnamed = '[No Name]',
                    },
                },
            }

            -- Right sections
            opts.sections.lualine_x = {
                {
                    'lsp_status',
                    icon = '󰒋 ',
                    symbols = {
                        spinner = require('config.icons').spinner.circle,
                        done = '✓',
                        separator = ' ',
                    },
                    ignore_lsp = {},
                    show_name = true,
                    always_visible = false,
                },
            }

            opts.sections.lualine_y = {}
            opts.sections.lualine_z = {
                {
                    'location',
                    padding = { left = 1, right = 1 },
                },
            }

            return opts
        end,
    },
}
