local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').twiggy_language_server.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { 'twig', 'twig.html' },
        })
    end,
}

return M
