local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig')['eslint'].setup({
            on_attach = function(client, bufnr)
                client.resolved_capabilities.document_formatting = true
                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
            settings = {
                format = {
                    enable = true,
                },
            },
        })
    end,
}

return M
