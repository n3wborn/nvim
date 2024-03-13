local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').dockerls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
}

return M
