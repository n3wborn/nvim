local M = {
    setup = function(capabilities)
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
            capabilities = capabilities,
        })
    end,
}

return M
