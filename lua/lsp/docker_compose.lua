local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').docker_compose_language_service.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
}

return M
