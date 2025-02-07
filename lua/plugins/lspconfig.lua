return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'b0o/schemastore.nvim',
    },
    opts = {
        inlay_hints = { enabled = true },
    },
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lspconfig.yamlls.setup({
            capabilities = capabilities,
            settings = {
                yaml = {
                    validate = true,
                    schemas = require('schemastore').yaml.schemas({
                        extra = {
                            url = 'file:///home/stephane/projects/qk-safety/plugins/surfaceCorePlugin/src/Resources/cheatsheet/generator.schema.json',
                            name = 'Generator',
                            fileMatch = 'generator.yml',
                        },
                    }),
                },
            },
        })

        -- lspconfig.twiggy_language_server.setup({
        --     capabilities = capabilities,
        --     filetypes = { 'twig', 'twig.html' },
        -- })

        lspconfig.tailwindcss.setup({
            settings = {
                tailwindCSS = {
                    validate = true,
                    lint = {
                        cssConflict = 'warning',
                        invalidApply = 'error',
                        invalidScreen = 'error',
                        invalidVariant = 'error',
                        invalidConfigPath = 'error',
                        invalidTailwindDirective = 'error',
                        recommendedVariantOrder = 'warning',
                    },
                    classAttributes = {
                        'class',
                        'className',
                        'class:list',
                        'classList',
                        'ngClass',
                    },
                },
            },
        })

        lspconfig.intelephense.setup({

            capabilities = capabilities,
            init_options = {
                licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
            },
            settings = {
                intelephense = {
                    files = {
                        maxSize = 10485760, -- 10Mo
                    },
                },
            },
        })

        for _, server in ipairs({
            'cssls',
            'cssmodules_ls',
            'css_variables',
            'docker_compose_language_service',
            --- @todo: find a better way to load when really needed
            -- 'custom_elements_ls',
            -- jsonls
            -- 'stimulus_ls',
        }) do
            lspconfig[server].setup({ capabilities = capabilities })
        end

        for _, server in ipairs({
            'emmet',
            'eslint',
            'neodev',
            --- @todo: once path to generator.yml is done (best wuld be a function to determine it)
        }) do
            require('lsp.' .. server).setup({ capabilities = capabilities })
        end

        vim.api.nvim_create_autocmd({ 'LspAttach' }, {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                local capabilities = client.server_capabilities

                -- diagnostics
                vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float)

                --- quickfix
                vim.keymap.set('n', '<leader>q', '<cmd>Trouble diagnostics<cr>', { buffer = args.buf })

                -- show definition of current symbol
                if capabilities.definitionProvider then
                    if client == 'typescript-tools' then
                        vim.keymap.set('n', '<leader>gd', '<cmd>TSToolsGoToSourceDefinition<cr>', { buffer = args.buf })
                    else
                        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { buffer = args.buf })
                    end
                end

                -- show declaration of current symbol
                if capabilities.declarationProvider then
                    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { buffer = args.buf })
                end

                -- show definition of current type
                if capabilities.typeDefinitionProvider then
                    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, { buffer = args.buf })
                end

                -- rename current symbol
                vim.keymap.set('n', '<leader>R', function()
                    if capabilities.renameProvider then
                        vim.lsp.buf.rename()
                    else
                        vim.notify('Provider does not have rename capability', vim.log.levels.INFO)
                    end
                end, { buffer = args.buf })

                -- show code actions available
                -- if capabilities.codeActionProvider then
                --     vim.keymap.set('n', '<leader>ca', function()
                --         require('fzf-lua').lsp_code_actions({
                --             winopts = {
                --                 relative = 'cursor',
                --                 width = 0.6,
                --                 height = 0.6,
                --                 row = 1,
                --                 preview = { vertical = 'up:70%' },
                --             },
                --         })
                --     end, { buffer = args.buf })
                -- end

                -- show signature help
                if capabilities.signatureHelpProvider then
                    vim.keymap.set('n', '<C-x><C-x>', vim.lsp.buf.signature_help, { buffer = args.buf })
                end

                -- vim.keymap.set('n', '<leader>P', function()
                --     if not capabilities.inlayHintProvider then
                --         vim.notify('Inlay hints unavailable', vim.log.levels.INFO)
                --     end
                --
                --     vim.notify('Inlay hints enabled', vim.log.levels.INFO)
                --     vim.lsp.inlay_hint.enable(true, { bufnr = vim.api.nvim_get_current_buf() })
                -- end, {})
            end,
        })
    end,
}
