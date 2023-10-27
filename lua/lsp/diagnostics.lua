local M = {}

function M.setup()
    vim.diagnostic.config({ virtual_text = false, float = _G.global.float_border_opts })
    local signs = require('custom.icons').diagnostics

    for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    vim.lsp.handlers['textDocument/diagnostic'] = vim.lsp.with(vim.lsp.diagnostic.on_diagnostic, {
        signs = function(_, bufnr)
            return vim.b[bufnr].show_signs == true
        end,
        update_in_insert = true,
    })
end

return M
