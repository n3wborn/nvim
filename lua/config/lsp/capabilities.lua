local lsp = vim.lsp
local api = vim.api

local fzf = require('fzf-lua')

return {
    {
        capability = 'textDocument/documentSymbol',
        keymaps = {
            {
                modes = { 'n', 'x' },
                lhs = '<leader>ss',
                rhs = fzf.lsp_document_symbols,
                desc = 'Document Symbols',
            },
            {
                modes = { 'n', 'x' },
                lhs = '<leader>sS',
                rhs = fzf.lsp_live_workspace_symbols,
                desc = 'Workspace Symbols',
            },
        },
    },
    {
        capability = 'textDocument/definition',

        keymaps = {
            {
                modes = 'n',
                lhs = 'gd',
                rhs = function()
                    fzf.lsp_definitions({ jump1 = true })
                end,
                desc = 'Goto Definition',
            },

            {
                modes = 'n',
                lhs = 'gD',
                rhs = function()
                    fzf.lsp_definitions({ jump1 = false })
                end,
                desc = 'Peek Definition',
            },
        },
    },
    {
        capability = 'textDocument/references',

        keymaps = {
            {
                modes = 'n',
                lhs = 'grr',
                rhs = '<cmd>FzfLua lsp_references<cr>',
                desc = 'References',
            },
        },
    },

    {
        capability = 'textDocument/documentColor',

        keymaps = {
            {
                modes = 'n',
                lhs = 'grc',
                rhs = function()
                    lsp.document_color.color_presentation()
                end,
                desc = 'Color Presentation',
            },
        },
    },

    {
        capability = 'textDocument/signatureHelp',

        keymaps = {
            {
                modes = 'i',
                lhs = '<C-k>',
                rhs = function()
                    local blink = require('blink.cmp')
                    local menu = require('blink.cmp.completion.windows.menu')

                    if menu.win:is_open() then
                        blink.hide()
                    end

                    lsp.buf.signature_help()
                end,
                desc = 'Signature Help',
            },
        },
    },

    {
        capability = 'textDocument/onTypeFormatting',

        setup = function(ctx)
            lsp.on_type_formatting.enable(true, {
                bufnr = ctx.bufnr,
            })
        end,
    },

    {
        capability = 'textDocument/inlayHint',

        condition = function()
            return vim.g.lsp_inlay_hints
        end,

        setup = function(ctx)
            lsp.inlay_hint.enable(true, {
                bufnr = ctx.bufnr,
            })
        end,
    },

    {
        capability = 'textDocument/documentHighlight',

        setup = function(ctx)
            local highlight_group = ctx.highlight_group

            api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
                group = highlight_group,
                buffer = ctx.bufnr,
                callback = lsp.buf.document_highlight,
            })

            api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
                group = highlight_group,
                buffer = ctx.bufnr,
                callback = lsp.buf.clear_references,
            })
        end,
    },
}
