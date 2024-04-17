local M = {
    setup = function(capabilities)
        require('lspconfig').twiggy_language_server.setup({
            capabilities = capabilities,
            filetypes = { 'twig', 'twig.html' },
        })
    end,
}

return M
