local M = {
    setup = function(on_attach, capabilities)
        local lspconfig = require('lspconfig')

        lspconfig['eslint'].setup({
            root_dir = lspconfig.util.root_pattern(
                '.eslintrc.js',
                '.eslintrc.cjs',
                '.eslintrc.yaml',
                '.eslintrc.yml',
                '.eslintrc.json'
            ),
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = true
                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
            settings = {
                codeAction = {
                    disableRuleComment = {
                        enable = true,
                        location = 'separateLine',
                    },
                    showDocumentation = {
                        enable = true,
                    },
                },
                codeActionOnSave = {
                    enable = false,
                    mode = 'all',
                },
                format = {
                    enable = true,
                },
                useESLintClass = true,
                packageManager = 'yarn',
                workingDirectory = {
                    mode = 'location',
                },
            },
        })
    end,
}

return M