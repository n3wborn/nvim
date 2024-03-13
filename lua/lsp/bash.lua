-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#css_variables
-- npm i -g css-variables-language-server
local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').bashls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
}

return M
