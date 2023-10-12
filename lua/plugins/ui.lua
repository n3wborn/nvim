return {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
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
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
            })
        end,
    },
    {
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
            fps = 20,
            background_colour = '#000000',
            render = 'compact',
            stages = 'fade_in_slide_out',
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
            on_open = function(win)
                vim.api.nvim_set_option_value('filetype', 'markdown', { buf = vim.api.nvim_win_get_buf(win) })
            end,
        },
    },
    {
        'akinsho/nvim-bufferline.lua',
        event = 'VeryLazy',
        keys = {
            { '<C-PageUp>', '<cmd>BufferLineCyclePrev<CR>', desc = 'move to previous buffer' },
            { '<C-PageDown>', '<cmd>BufferLineCycleNext<CR>', desc = 'move to next buffer' },
        },
        opts = {
            options = {
                diagnostics = 'nvim_lsp',
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    local icons = require('custom.icons').diagnostics
                    local s = {}
                    local severities = {
                        'Error',
                        'Warning',
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
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        main = 'ibl',
        opts = {
            indent = {
                char = '│',
            },
            scope = {
                show_start = false,
                show_end = false,
            },
        },
    },
    {
        'anuvyklack/windows.nvim',
        config = true,
        dependencies = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim',
        },
        keys = {
            { '<C-w>z', '<cmd>WindowsMaximize<cr>', desc = 'Maximize Windows' },
            { '<C-w>_', '<cmd>WindowsMaximizeVertically<cr>', desc = 'Maximize Vertically' },
            { '<C-w>|', '<cmd>WindowsMaximizeHorizontally<cr>', desc = 'Maximize Horizontaly' },
            { '<C-w>=', '<cmd>WindowsEqualize<cr>', desc = 'Equalize Windows' },
        },
    },
    {
        'NvChad/nvim-colorizer.lua',
        event = 'BufReadPre',
        opts = {
            filetypes = { 'javascript', 'typescript', 'html', 'css', 'scss', '!lazy', '!prompt', '!nofile' },
            buftype = { 'javascript', 'typescript', 'html', 'css', 'scss' },
        },
    },
}
