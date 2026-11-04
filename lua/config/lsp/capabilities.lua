local lsp = vim.lsp
local api = vim.api

return {
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
