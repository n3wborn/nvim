-- Lualine statusline styling (Catppuccin Mocha themed)
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

            -- Custom purple theme colors (matching NONE background)
            local colors = {
                bg = 'NONE',
                fg = '#cdd6f4',
                mauve = '#cba6f7',
                blue = '#89b4fa',
                green = '#a6e3a1',
                peach = '#fab387',
                red = '#f38ba8',
                yellow = '#f9e2af',
                surface0 = '#313244',
                overlay0 = '#6c7086',
            }

            opts.options = opts.options or {}
            opts.options.component_separators = { left = '│', right = '│' }
            opts.options.section_separators = { left = '', right = '' }
            opts.options.globalstatus = true
            opts.options.theme = {
                normal = {
                    a = { fg = colors.mauve, bg = colors.bg, gui = 'bold' },
                    b = { fg = colors.blue, bg = colors.bg },
                    c = { fg = colors.fg, bg = colors.bg },
                    x = { fg = colors.blue, bg = colors.bg },
                    y = { fg = colors.green, bg = colors.bg },
                    z = { fg = colors.mauve, bg = colors.bg },
                },
                insert = {
                    a = { fg = colors.green, bg = colors.bg, gui = 'bold' },
                },
                visual = {
                    a = { fg = colors.peach, bg = colors.bg, gui = 'bold' },
                },
                replace = {
                    a = { fg = colors.red, bg = colors.bg, gui = 'bold' },
                },
                command = {
                    a = { fg = colors.yellow, bg = colors.bg, gui = 'bold' },
                },
                inactive = {
                    a = { fg = colors.overlay0, bg = colors.bg },
                    b = { fg = colors.overlay0, bg = colors.bg },
                    c = { fg = colors.overlay0, bg = colors.bg },
                },
            }

            -- Left sections
            opts.sections = opts.sections or {}
            opts.sections.lualine_a = {
                {
                    'mode',
                    fmt = function(str)
                        local mode_map = {
                            N = '🧠 N',
                            I = '✏️ I',
                            V = '👁️ V',
                            C = '⌨️ C',
                            R = '🔄 R',
                            T = '💻 T',
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
                    icon = '󰊢',
                    padding = { left = 1, right = 1 },
                },
                {
                    'diff',
                    symbols = {
                        added = '+',
                        modified = '~',
                        removed = '-',
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
                    color = { fg = colors.overlay0 },
                },
            }

            -- Right sections
            opts.sections.lualine_x = {
                {
                    function()
                        local clients = vim.lsp.get_clients({ bufnr = 0 })
                        if #clients > 0 then
                            return '󰒋 ' .. clients[1].name
                        end
                        return ''
                    end,
                    color = { fg = colors.blue },
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
            icons = {
                File = '󰈙 ',
                Module = ' ',
                Namespace = '󰌗 ',
                Package = ' ',
                Class = '󰠱 ',
                Method = '󰆧 ',
                Property = ' ',
                Field = ' ',
                Constructor = ' ',
                Enum = '󰕘 ',
                Interface = '󰕘 ',
                Function = '󰊕 ',
                Variable = '󰆧 ',
                Constant = '󰏿 ',
                String = '󰀬 ',
                Number = '󰎠 ',
                Boolean = '◩ ',
                Array = '󰅪 ',
                Object = '󰅩 ',
                Key = '󰌋 ',
                Null = '󰟢 ',
                EnumMember = ' ',
                Struct = '󰙅 ',
                Event = ' ',
                Operator = '󰆕 ',
                TypeParameter = '󰊄 ',
            },
        },
    },
}
