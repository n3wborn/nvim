return {
    {
        'echasnovski/mini.align',
        version = false,
        event = 'VeryLazy',
        config = function()
            require('mini.align').setup()
        end,
    },
    {
        'utilyre/barbecue.nvim',
        name = 'barbecue',
        event = { 'BufEnter' },
        version = '*',
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('barbecue').setup({
                attach_navic = true,
                show_dirname = false,
                theme = 'catpuccin-mocha',
                create_autocmd = false,
            })

            vim.api.nvim_create_autocmd({
                'WinResized',
                'BufWinEnter',
                'CursorHold',
                'InsertLeave',

                -- include this if you have set `show_modified` to `true`
                'BufModifiedSet',
            }, {
                group = vim.api.nvim_create_augroup('barbecue.updater', {}),
                callback = function()
                    require('barbecue.ui').update()
                end,
            })
        end,
    },
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
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
                integrations = {
                    barbecue = {
                        dim_dirname = true,
                    },
                    cmp = true,
                    coc_nvim = false,
                    diffview = true,
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = false,
                    },
                    gitsigns = true,
                    markdown = true,
                    mason = true,
                    mini = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { 'italic' },
                            hints = { 'italic' },
                            warnings = { 'italic' },
                            information = { 'italic' },
                        },
                        underlines = {
                            errors = { 'underline' },
                            hints = { 'underline' },
                            warnings = { 'underline' },
                            information = { 'underline' },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    navic = true,
                    neotree = true,
                    noice = true,
                    notify = true,
                    nvim_surround = true,
                    nvimtree = true,
                    window_picker = true,
                    rainbow_delimiters = true,
                    semantic_tokens = true,
                    snacks = true,
                    symbols_outline = true,
                    telescope = true,
                    treesitter = true,
                    treesitter_context = true,
                },
                custom_highlights = function(c)
                    return {
                        CmpItemKindSnippet = { fg = c.base, bg = c.mauve },
                        CmpItemKindKeyword = { fg = c.base, bg = c.red },
                        CmpItemKindText = { fg = c.base, bg = c.teal },
                        CmpItemKindMethod = { fg = c.base, bg = c.blue },
                        CmpItemKindConstructor = { fg = c.base, bg = c.blue },
                        CmpItemKindFunction = { fg = c.base, bg = c.blue },
                        CmpItemKindFolder = { fg = c.base, bg = c.blue },
                        CmpItemKindModule = { fg = c.base, bg = c.blue },
                        CmpItemKindConstant = { fg = c.base, bg = c.peach },
                        CmpItemKindField = { fg = c.base, bg = c.green },
                        CmpItemKindProperty = { fg = c.base, bg = c.green },
                        CmpItemKindEnum = { fg = c.base, bg = c.green },
                        CmpItemKindUnit = { fg = c.base, bg = c.green },
                        CmpItemKindClass = { fg = c.base, bg = c.yellow },
                        CmpItemKindVariable = { fg = c.base, bg = c.flamingo },
                        CmpItemKindFile = { fg = c.base, bg = c.blue },
                        CmpItemKindInterface = { fg = c.base, bg = c.yellow },
                        CmpItemKindColor = { fg = c.base, bg = c.red },
                        CmpItemKindReference = { fg = c.base, bg = c.red },
                        CmpItemKindEnumMember = { fg = c.base, bg = c.red },
                        CmpItemKindStruct = { fg = c.base, bg = c.blue },
                        CmpItemKindValue = { fg = c.base, bg = c.peach },
                        CmpItemKindEvent = { fg = c.base, bg = c.blue },
                        CmpItemKindOperator = { fg = c.base, bg = c.blue },
                        CmpItemKindTypeParameter = { fg = c.base, bg = c.blue },
                        CmpItemKindCopilot = { fg = c.base, bg = c.teal },
                        CursorLineNr = { fg = c.base, bg = c.surface1 },
                        ColorColumn = { bg = c.surface0 },
                    }
                end,
            })

            vim.cmd.colorscheme('catppuccin')
        end,
    },
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
                    lualine_y = {},
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    -- lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
            }
        end,
        config = function(_, opts)
            require('lualine').setup(opts)
        end,
    },
    {
        'NvChad/nvim-colorizer.lua',
        event = 'BufReadPre',
        opts = {
            filetypes = { 'javascript', 'typescript', 'html', 'css', 'scss', '!lazy', '!prompt', '!nofile' },
            buftype = { 'javascript', 'typescript', 'html', 'css', 'scss' },
        },
    },
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
    {
        'SmiteshP/nvim-navic',
        dependencies = 'neovim/nvim-lspconfig',
        opts = {
            lsp = {
                auto_attach = false,
                preference = nil,
            },
            highlight = true,
            separator = '❯ ',
            depth_limit = 0,
            depth_limit_indicator = '..',
            safe_output = true,
        },
    },
    {
        'wurli/contextindent.nvim',
        -- This is the only config option; you can use it to restrict the files
        -- which this plugin will affect (see :help autocommand-pattern).
        opts = { pattern = '*' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
    },
    {
        'chrisgrieser/nvim-origami',
        event = 'BufReadPost', -- later will not save folds
        opts = true,
    },
    { -- UFO
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = 'BufReadPost', -- needed for folds to load in time
        keys = {
            {
                'zr',
                function()
                    require('ufo').openFoldsExceptKinds({ 'imports', 'comment' })
                end,
                desc = ' 󱃄 Open All Folds except comments',
            },
            {
                'zm',
                function()
                    require('ufo').closeAllFolds()
                end,
                desc = ' 󱃄 Close All Folds',
            },
            {
                'z1',
                function()
                    require('ufo').closeFoldsWith(1)
                end,
                desc = ' 󱃄 Close L1 Folds',
            },
            {
                'z2',
                function()
                    require('ufo').closeFoldsWith(2)
                end,
                desc = ' 󱃄 Close L2 Folds',
            },
            {
                'z3',
                function()
                    require('ufo').closeFoldsWith(3)
                end,
                desc = ' 󱃄 Close L3 Folds',
            },
            {
                'z4',
                function()
                    require('ufo').closeFoldsWith(4)
                end,
                desc = ' 󱃄 Close L4 Folds',
            },
        },
        init = function()
            -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
            -- auto-closing them after leaving insert mode, however ufo does not seem to
            -- have equivalents for zr and zm because there is no saved fold level.
            -- Consequently, the vim-internal fold levels need to be disabled by setting
            -- them to 99
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
        opts = {
            provider_selector = function(_, ft, _)
                -- INFO some filetypes only allow indent, some only LSP, some only
                -- treesitter. However, ufo only accepts two kinds as priority,
                -- therefore making this function necessary :/
                local lspWithOutFolding = { 'markdown', 'sh', 'css', 'html', 'python' }
                if vim.tbl_contains(lspWithOutFolding, ft) then
                    return { 'treesitter', 'indent' }
                end
                return { 'lsp', 'indent' }
            end,
            -- open opening the buffer, close these fold kinds
            -- use `:UfoInspect` to get available fold kinds from the LSP
            close_fold_kinds_for_ft = { lsp = { 'imports', 'comment' } },
            open_fold_hl_timeout = 800,
            fold_virt_text_handler = require('utils').foldTextFormatter,
        },
    },
}
