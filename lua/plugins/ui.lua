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
                local buf = vim.api.nvim_win_get_buf(win)
                vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
            end,
        },
    },
    {
        'akinsho/nvim-bufferline.lua',
        event = 'VeryLazy',
        opts = {
            options = {
                diagnostics = 'nvim_lsp',
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    local icons = require('custom.icons').diagnostics
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
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
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
            show_current_context = true,
        },
    },
    --[[ {
        'tzachar/local-highlight.nvim',
        config = function()
            require('local-highlight').setup()
        end,
    }, ]]
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = function()
            local navic = require('nvim-navic')
            local config = {
                options = {
                    icons_enabled = true,
                    theme = 'catpuccin',
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
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                extensions = {
                    'quickfix',
                    'nvim-tree',
                },
            }

            local function ins_left(component)
                table.insert(config.sections.lualine_c, component)
            end

            ins_left({
                'lsp_progress',
                display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
                separators = {
                    component = ' ',
                    progress = ' | ',
                    percentage = { pre = '', post = '%% ' },
                    title = { pre = '', post = ': ' },
                    lsp_client_name = { pre = '[', post = ']' },
                    spinner = { pre = '', post = '' },
                    message = { commenced = 'In Progress', completed = 'Completed' },
                },
                timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
                spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
            })
        end,
        config = function(_, opts)
            require('lualine').setup(opts)
        end,
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
}
