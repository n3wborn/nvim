-- From BrendonJL/dotfiles
return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = {
            'SmiteshP/nvim-navic', -- For showing current function/symbol
        },
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
            opts.sections.lualine_a = {
                {
                    'mode',
                    fmt = function(str)
                        local mode_map = {
                            N = '[NORMAL]',
                            I = '[INSERT]',
                            V = '[VISUAL]',
                            C = '[COMMAND]',
                            R = '[REPLACE]',
                            T = '[TERM]',
                        }
                        local letter = str:sub(1, 1)
                        return mode_map[letter] or ('  ' .. letter)
                    end,
                    padding = { left = 1, right = 1 },
                },
            }

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
                { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                {
                    'filename',
                    path = 1,
                    symbols = {
                        modified = ' ●',
                        readonly = ' ',
                        unnamed = '[No Name]',
                    },
                },
                -- Show current function/symbol via navic
                {
                    function()
                        local navic = require('nvim-navic')
                        if navic.is_available() then
                            local location = navic.get_location()
                            if location ~= '' then
                                return '› ' .. location
                            end
                        end
                        return ''
                    end,
                    cond = function()
                        return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
                    end,
                    -- color = { fg = colors.overlay0 },
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
                },
            }

            opts.sections.lualine_y = {
                {
                    'filetype',
                    icon_only = false,
                    padding = { left = 1, right = 1 },
                },
            }

            opts.sections.lualine_z = {
                {
                    'location',
                    padding = { left = 1, right = 1 },
                },
                {
                    'progress',
                    padding = { left = 0, right = 1 },
                },
            }

            return opts
        end,
    },
    -- Navic for breadcrumbs (current function)
    {
        'SmiteshP/nvim-navic',
        lazy = true,
        opts = {
            lsp = {
                auto_attach = true,
            },
            highlight = true,
            separator = ' › ',
            depth_limit = 3,
            icons = require('config.icons'),
        },
    },
}
