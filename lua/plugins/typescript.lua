return {
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                'typescript-language-server',
                'eslint-lsp',
            })
        end,
    },
    {
        'pmizio/typescript-tools.nvim',
        dependencies = {
            'oleggulevskyy/better-ts-errors.nvim',
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
        },
        ft = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
        },
        opts = {
            jsx_close_tag = { enable = true },
            tsserver_plugins = {
                '@styled/typescript-styled-plugin',
            },
            -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3418
            tsserver_format_options = {
                allowIncompleteCompletions = false,
                allowRenameOfImportPath = true,
            },
            --- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
            tsserver_file_preferences = {
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
                includeCompletionsForModuleExports = true,
            },
            expose_as_code_action = 'all',
            complete_function_calls = true,
        },
        config = function(_, opts)
            local utils = require('utils')
            utils.on_attach('tsserver', function(_, bufnr)
                require('better-ts-errors').setup()
                vim.keymap.set(
                    'n',
                    '<leader>lo',
                    '<cmd>TSToolsOrganizeImports<cr>',
                    { buffer = bufnr, desc = 'Organize Imports' }
                )
                vim.keymap.set(
                    'n',
                    '<leader>lO',
                    '<cmd>TSToolsSortImports<cr>',
                    { buffer = bufnr, desc = 'Sort Imports' }
                )
                vim.keymap.set(
                    'n',
                    '<leader>lu',
                    '<cmd>TSToolsRemoveUnused<cr>',
                    { buffer = bufnr, desc = 'Removed Unused' }
                )
                vim.keymap.set(
                    'n',
                    '<leader>gd',
                    '<cmd>TSToolsGoToSourceDefinition<cr>',
                    { buffer = bufnr, desc = 'Go To Source Definition' }
                )
                vim.keymap.set(
                    'n',
                    '<leader>lR',
                    '<cmd>TSToolsRemoveUnusedImports<cr>',
                    { buffer = bufnr, desc = 'Removed Unused Imports' }
                )
                vim.keymap.set('n', '<leader>lF', '<cmd>TSToolsFixAll<cr>', { buffer = bufnr, desc = 'Fix All' })
                vim.keymap.set(
                    'n',
                    '<leader>lA',
                    '<cmd>TSToolsAddMissingImports<cr>',
                    { buffer = bufnr, desc = 'Add Missing Imports' }
                )
                if vim.fn.has('nvim-0.10') then
                    vim.lsp.inlay_hint(bufnr, true)
                end
            end)
            require('typescript-tools').setup(opts)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'pmizio/typescript-tools.nvim' },
        opts = {
            servers = {
                eslint = {
                    settings = {
                        -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
                        workingDirectory = { mode = 'auto' },
                    },
                },
            },
            setup = {
                eslint = function()
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        callback = function(event)
                            local client = vim.lsp.get_clients({ bufnr = event.buf, name = 'eslint' })[1]
                            if client then
                                local diag = vim.diagnostic.get(
                                    event.buf,
                                    { namespace = vim.lsp.diagnostic.get_namespace(client.id) }
                                )
                                if #diag > 0 then
                                    vim.cmd('EslintFixAll')
                                end
                            end
                        end,
                    })
                end,
                tsserver = function()
                    -- skip mason-lspconfig auto setup
                    return true
                end,
            },
        },
    },
}
