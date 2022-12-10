local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
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
    end,
}

return M
