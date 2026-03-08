return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
        -- Command line in center with sleek popup
        cmdline = {
            enabled = true,
            view = 'cmdline_popup',
            opts = {
                position = {
                    row = '40%',
                    col = '50%',
                },
                size = {
                    width = 70,
                    height = 'auto',
                },
                border = {
                    style = 'rounded',
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = {
                        Normal = 'Normal',
                        IncSearch = '',
                        CurSearch = '',
                    },
                },
            },
            format = {
                cmdline = {
                    pattern = '^:',
                    icon = '❯',
                    lang = 'vim',
                    title = '',
                },
                search_down = {
                    kind = 'search',
                    pattern = '^/',
                    icon = '🔍',
                    lang = 'regex',
                    title = '',
                },
                search_up = {
                    kind = 'search',
                    pattern = '^%?',
                    icon = '🔍',
                    lang = 'regex',
                    title = '',
                },
                filter = {
                    pattern = '^:%s*!',
                    icon = '$',
                    lang = 'bash',
                    title = '',
                },
                lua = {
                    pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' },
                    icon = '☾',
                    lang = 'lua',
                    title = '',
                },
                help = {
                    pattern = '^:%s*he?l?p?%s+',
                    icon = '?',
                    title = '',
                },
            },
        },

        -- Message handling
        messages = {
            enabled = true,
            view = 'notify',
            view_error = 'notify',
            view_warn = 'notify',
            view_history = 'messages',
            view_search = 'virtualtext',
        },

        -- Better popups
        popupmenu = {
            enabled = true,
            backend = 'nui',
            kind_icons = true,
        },

        -- Simple routes - just skip annoying messages
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    any = {
                        { find = 'written' },
                        { find = '%d+L, %d+B' },
                        { find = '; after #%d+' },
                        { find = '; before #%d+' },
                        { find = 'No information available' },
                    },
                },
                opts = { skip = true },
            },
            -- Hide stuck LSP progress messages (pyright "analyzing")
            {
                filter = {
                    event = 'lsp',
                    kind = 'progress',
                    find = 'Analyz',
                },
                opts = { skip = true },
            },
        },

        -- LSP configuration
        lsp = {
            progress = {
                enabled = false, -- Disable stuck progress messages
            },
            -- override = {
            --     ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            --     ['vim.lsp.util.stylize_markdown'] = true,
            --     ['cmp.entry.get_documentation'] = true,
            -- },
            hover = {
                enabled = true,
                silent = false,
            },
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = true,
                    luasnip = true,
                    throttle = 50,
                },
            },
            message = {
                enabled = true,
                view = 'notify',
            },
            documentation = {
                view = 'hover',
                opts = {
                    lang = 'markdown',
                    replace = true,
                    render = 'plain',
                    format = { '{message}' },
                    win_options = { concealcursor = 'n', conceallevel = 3 },
                },
            },
        },

        -- Notifications
        notify = {
            enabled = true,
            view = 'notify',
        },

        -- Presets
        presets = {
            bottom_search = false,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = true,
            lsp_doc_border = true,
        },

        -- Custom views
        views = {
            cmdline_popup = {
                position = {
                    row = '40%',
                    col = '50%',
                },
                size = {
                    width = 70,
                    height = 'auto',
                },
                border = {
                    style = 'rounded',
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = {
                        Normal = 'NormalFloat',
                        FloatBorder = 'NoiceCmdlinePopupBorder',
                    },
                },
            },
            -- popupmenu = {
            --     relative = 'editor',
            --     position = {
            --         row = '45%',
            --         col = '50%',
            --     },
            --     size = {
            --         width = 70,
            --         height = 10,
            --     },
            --     border = {
            --         style = 'rounded',
            --         padding = { 0, 1 },
            --     },
            --     win_options = {
            --         winhighlight = {
            --             Normal = 'NoicePopupmenu',
            --             FloatBorder = 'NoicePopupmenuBorder',
            --             CursorLine = 'NoicePopupmenuSelected',
            --         },
            --     },
            -- },
        },
    },
}
