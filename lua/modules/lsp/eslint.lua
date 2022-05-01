local M = {
    setup = function(on_attach, capabilities)
        local lspconfig = require('lspconfig')

        lspconfig['eslint'].setup({
            root_dir = lspconfig.util.root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.json'),
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = true
                client.server_capabilities.documentRangeFormattingProvider = true
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
            handlers = {
                -- this error shows up occasionally when formatting
                -- formatting actually works, so this will supress it
                ['window/showMessageRequest'] = function(_, result)
                    if result.message:find('ENOENT') then
                        return vim.NIL
                    end

                    return vim.lsp.handlers['window/showMessageRequest'](nil, result)
                end,
            },
        })
    end,
}

return M
