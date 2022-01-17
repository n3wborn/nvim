local M = {
    setup = function(on_attach, capabilities)
        require('lspconfig')['eslint'].setup({
            on_attach = function(client, bufnr)
                client.resolved_capabilities.document_formatting = true
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
                format = true,
                nodePath = '',
                onIgnoredFiles = 'off',
                packageManager = 'yarn',
                quiet = false,
                rulesCustomizations = {},
                run = 'onType',
                useESLintClass = false,
                validate = 'on',
                workingDirectory = {
                    mode = 'location',
                },
            },
        })
    end,
}

return M
