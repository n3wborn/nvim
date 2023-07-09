local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').emmet_language_server.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}

return M
