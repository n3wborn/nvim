return {
    'catppuccin/nvim',
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
                cmp = true,
                gitsigns = true,
                mini = false,
                notify = true,
                semantic_tokens = true,
                nvimtree = true,
                telescope = true,
            },
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,
            },
            navic = {
                enabled = true,
                custom_bg = 'NONE',
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
                }
            end,
        })

        vim.cmd.colorscheme('catppuccin')
    end,
}
