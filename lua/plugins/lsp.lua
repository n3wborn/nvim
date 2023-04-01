return {
    { 'nvim-lua/plenary.nvim' },
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
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local nls = require('null-ls')
            local b = require('null-ls.builtins')

            local with_root_file = function(builtin, file)
                return builtin.with({
                    condition = function(utils)
                        return utils.root_has_file(file)
                    end,
                })
            end

            nls.setup({
                debounce = 150,
                save_after_format = false,
                sources = {
                    --- code actions
                    b.code_actions.eslint,
                    b.code_actions.gitrebase,
                    b.code_actions.refactoring,
                    b.code_actions.shellcheck,
                    --- diagnostics
                    b.diagnostics.gitlint,
                    b.diagnostics.markdownlint,
                    b.diagnostics.php,
                    b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
                    b.diagnostics.todo_comments,
                    b.diagnostics.trail_space,
                    b.diagnostics.tsc,
                    b.diagnostics.zsh,
                    --- formatting
                    b.formatting.blade_formatter,
                    b.formatting.eslint_d,
                    b.formatting.fixjson,
                    b.formatting.goimports,
                    b.formatting.phpcsfixer.with({
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
                    b.formatting.phpcsfixer.with({
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
                    b.formatting.prettier.with({
                        disabled_filetypes = { 'typescript', 'typescriptreact' },
                    }),
                    b.formatting.rustfmt,
                    b.formatting.shfmt,
                    b.formatting.sqlformat,
                    with_root_file(b.formatting.stylua, 'stylua.toml'),
                },
            })
        end,
    },
}
