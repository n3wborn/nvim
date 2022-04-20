local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').gopls.setup({
        capabilities = capabilities,
        on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            on_attach(client)
        end,
        settings = {
            gopls = {
                usePlaceholders = true,
                analyses = {
                    nilness = true,
                    shadow = true,
                    unusedparams = true,
                    unusewrites = true,
                },
            },
        },
    })
end

return M
