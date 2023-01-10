local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').emmet_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            flags = lsp_flags,
        })
    end,
}

return M
