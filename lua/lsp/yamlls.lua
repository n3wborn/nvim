local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig').yamlls.setup({
            settings = {
                yaml = {
                    schemas = require('schemastore').yaml.schemas({
                        extra = {
                            --- @todo: see lsp.lua
                            url = 'generator.schema.json',
                            name = 'Generator',
                            fileMatch = 'generator.yml',
                        },
                    }),
                },
            },
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
}

return M
