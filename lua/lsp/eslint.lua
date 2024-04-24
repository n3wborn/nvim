-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
local M = {
    setup = function(capabilities)
        require('lspconfig').eslint.setup({
            capabilities = capabilities,
            cmd = { 'vscode-eslint-language-server', '--stdio' },
            filetypes = {
                'javascript',
                'javascriptreact',
                'javascript.jsx',
                'typescript',
                'typescriptreact',
                'typescript.tsx',
                'vue',
                'svelte',
                'astro',
            },
            settings = {
                validate = 'on',
                useESLintClass = false,
                experimental = {
                    useFlatConfig = false,
                },
                codeActionOnSave = {
                    enable = false,
                    mode = 'all',
                },
                format = false,
                quiet = false,
                onIgnoredFiles = 'off',
                rulesCustomizations = {},
                run = 'onType',
                problems = {
                    shortenToSingleLine = false,
                },
                codeAction = {
                    disableRuleComment = {
                        enable = true,
                        location = 'separateLine',
                    },
                    showDocumentation = {
                        enable = true,
                    },
                },
            },
        })
    end,
}

return M
