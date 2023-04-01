return {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    {
        'folke/noice.nvim',
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
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
            })
        end,
    },
    {
        -- Better `vim.notify()`
        'rcarriga/nvim-notify',
        keys = {
            {
                '<leader>un',
                function()
                    require('notify').dismiss({ silent = true, pending = true })
                end,
                desc = 'Delete all Notifications',
            },
        },
        opts = {
            timeout = 2000,
            render = 'compact',
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },

    -- bufferline
    {
        'akinsho/nvim-bufferline.lua',
        event = 'VeryLazy',
        opts = {
            options = {
                diagnostics = 'nvim_lsp',
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    local icons = require('lazyvim.config').icons.diagnostics
                    local s = {}
                    local severities = {
                        'error',
                        'warning',
                    }

                    for _, severity in ipairs(severities) do
                        if diag[severity] then
                            table.insert(s, icons[severity] .. diag[severity])
                        end
                    end

                    return table.concat(s, ' ')
                end,
                offsets = {
                    {
                        filetype = { 'neo-tree', 'NvimTree' },
                        text = { 'Neo-tree', 'NvimTree' },
                        highlight = 'Directory',
                        text_align = 'left',
                    },
                },
            },
        },
    },

    -- indent guides for Neovim
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPost',
        opts = {
            char = '▏',
            filetype_exclude = {
                'help',
                'alpha',
                'dashboard',
                'neo-tree',
                'Trouble',
                'lazy',
                'lspinfo',
                'packer',
                'checkhealth',
                'man',
                'terminal',
            },
            use_treesitter = true,
            max_indent_increase = 1,
            show_first_indent_level = false,
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
    },
}
