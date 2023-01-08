return {
    -- neodev
    {
        'folke/neodev.nvim',
        config = {
            debug = true,
            experimental = {
                pathStrict = true,
            },
            library = {
                runtime = '~/prog/git/neovim/runtime/',
            },
        },
    },

    -- tools
    {
        'williamboman/mason.nvim',
        ensure_installed = {
            'emmet',
            'eslint',
            'eslint_d',
            'luacheck',
            'prettier',
            'prettierd',
            'shellcheck',
            'shfmt',
            'stylua',
            'tsserver',
        },
    },

    -- json schemas
    'b0o/SchemaStore.nvim',

    -- lsp servers
    {
        'neovim/nvim-lspconfig',
        ---@type lspconfig.options
        servers = {
            bashls = {},
            cssls = {},
            dockerls = {},
            tsserver = {},
            eslint = {},
            emmet = {},
            html = {},
            jsonls = {
                on_new_config = function(new_config)
                    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                    vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
                end,
                settings = {
                    json = {
                        format = {
                            enable = true,
                        },
                        validate = { enable = true },
                    },
                },
            },
            gopls = {},
            rust_analyzer = {
                settings = {
                    ['rust-analyzer'] = {
                        cargo = { allFeatures = true },
                        checkOnSave = {
                            command = 'clippy',
                            extraArgs = { '--no-deps' },
                        },
                    },
                },
            },
            yamlls = {},
            sumneko_lua = {
                single_file_support = true,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                'vim',
                                'use',
                                'describe',
                                'it',
                                'assert',
                                'before_each',
                                'after_each',
                            },
                        },
                        completion = {
                            showWord = 'Disable',
                            callSnippet = 'Disable',
                            keywordSnippet = 'Disable',
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            },
                        },
                    },
                },
            },
            vimls = {},
        },
    },

    -- null-ls
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local nls = require('null-ls')

            local with_root_file = function(builtin, file)
                return builtin.with({
                    condition = function(utils)
                        return utils.root_has_file(file)
                    end,
                })
            end

            nls.setup({
                debounce = 150,
                save_after_format = true,
                sources = {
                    --- code actions
                    nls.code_actions.eslint,
                    nls.code_actions.gitrebase,
                    nls.code_actions.refactoring,
                    nls.code_actions.shellcheck,
                    --- diagnostics
                    nls.diagnostics.gitlint,
                    nls.diagnostics.markdownlint,
                    nls.diagnostics.php,
                    nls.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
                    nls.diagnostics.todo_comments,
                    nls.diagnostics.trail_space,
                    nls.diagnostics.tsc,
                    nls.diagnostics.zsh,
                    --- formatting
                    nls.formatting.blade_formatter,
                    nls.formatting.eslint_d,
                    nls.formatting.fixjson,
                    nls.formatting.goimports,
                    nls.formatting.phpcsfixer.with({
                        filetypes = { 'php' },
                        command = 'php-cs-fixer',
                        args = {
                            '--no-interaction',
                            '--quiet',
                            '--using-cache=' .. 'no',
                            '--config=' .. '$ROOT' .. '/.php-cs-fixer.php',
                            'fix',
                            '$FILENAME',
                        },
                        condition = function(utils)
                            return utils.root_has_file('.php-cs-fixer.php')
                        end,
                    }),
                    nls.formatting.phpcsfixer.with({
                        filetypes = { 'php' },
                        command = 'php-cs-fixer',
                        args = {
                            '--no-interaction',
                            '--quiet',
                            '--using-cache=' .. 'no',
                            '--rules=' .. '@PSR12,@Symfony',
                            'fix',
                            '$FILENAME',
                        },
                        condition = function(utils)
                            return not utils.root_has_file('.php-cs-fixer.php')
                        end,
                    }),
                    nls.formatting.prettier.with({
                        disabled_filetypes = { 'typescript', 'typescriptreact' },
                    }),
                    nls.formatting.rustfmt,
                    nls.formatting.shfmt,
                    nls.formatting.sqlformat,
                    with_root_file(nls.formatting.stylua, 'stylua.toml'),
                },
            })
        end,
    },
}
