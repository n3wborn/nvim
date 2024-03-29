return {
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
                aerial = false,
                barbar = false,
                barbecue = {
                    dim_dirname = true,
                },
                beacon = false,
                cmp = true,
                coc_nvim = false,
                dap = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                dashboard = true,
                fern = false,
                fidget = false,
                gitgutter = false,
                gitsigns = true,
                harpoon = false,
                hop = false,
                illuminate = true,
                leap = false,
                lightspeed = false,
                lsp_saga = false,
                lsp_trouble = true,
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
                neogit = true,
                neotest = false,
                neotree = true,
                noice = true,
                notify = true,
                nvimtree = true,
                overseer = false,
                pounce = false,
                rainbow_delimiters = true,
                semantic_tokens = true,
                symbols_outline = true,
                telekasten = false,
                telescope = true,
                treesitter = true,
                treesitter_context = false,
                ts_rainbow = true,
                vim_sneak = false,
                vimwiki = false,
                which_key = false,
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
}
