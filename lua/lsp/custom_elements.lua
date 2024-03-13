local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').custom_elements_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
}

return M
