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
                client.server_capabilities.documentFormattingProvider = false
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
                    enable = false,
                },
                useESLintClass = true,
                packageManager = 'yarn',
                workingDirectory = {
                    mode = 'location',
                },
            },
            root_dir = require('lspconfig.util').find_git_ancestor,
        })
    end,
}

return M
