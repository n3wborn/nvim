local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').css_variables.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
}

return M
