return {
    {
        'RRethy/vim-illuminate',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            providers = {
                'lsp',
                'treesitter',
            },
            filetypes_denylist = {
                'nvimTree',
                'nvim-tree',
                'neo-tree',
                'lazy',
                'telescope',
            },
        },
        config = function(_, opts)
            require('illuminate').configure(opts)

            vim.cmd('hi link illuminatedWord Visual')
        end,
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = 'TextChanged',
        },
        keys = {
            {
                '<tab>',
                function()
                    return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
                end,
                expr = true,
                silent = true,
                mode = 'i',
            },
            {
                '<tab>',
                function()
                    require('luasnip').jump(1)
                end,
                mode = 's',
            },
            {
                '<s-tab>',
                function()
                    require('luasnip').jump(-1)
                end,
                mode = { 'i', 's' },
            },
        },
    },
    { 'folke/neodev.nvim', opts = {} },
    {
        'SmiteshP/nvim-navbuddy',
        cmd = 'Navbuddy',
        keys = {
            { '<leader>N', '<cmd>Navbuddy<cr>', desc = 'nabuddy' },
        },
        dependencies = {
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
        },
        opts = { lsp = { auto_attach = true } },
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'b0o/schemastore.nvim',
        },
        opts = {
            inlay_hints = { enabled = true },
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- diagnostics
            require('lsp.diagnostics').setup()

            --- on_attach
            local on_attach = function(client)
                require('illuminate').on_attach(client)
            end

            -- required servers
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'sh',
                callback = function()
                    vim.lsp.start({
                        name = 'bash-language-server',
                        cmd = { 'bash-language-server', 'start' },
                    })
                end,
            })

            vim.api.nvim_create_autocmd({ 'FileType' }, {
                pattern = { 'dockerfile' },
                callback = function()
                    local config = {
                        name = 'dockerls',
                        cmd = { 'docker-langserver', '--stdio' },
                        root_dir = vim.fs.dirname(vim.fs.find({ 'Dockerfile' }, { upward = true })[1]),
                    }

                    vim.lsp.start(config, {
                        reuse_client = function(client, conf)
                            return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
                        end,
                    })
                end,
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'yaml,yml',
                callback = function()
                    vim.lsp.start({
                        name = 'docker-compose-langserver',
                        cmd = { 'docker-compose-langserver', '--stdio' },
                        root_dir = vim.fs.dirname(vim.fs.find({
                            'docker-compose.yml',
                            'docker-compose.yaml',
                            'compose.yml',
                            'compose.yaml',
                            -- stylua: ignore
                            "compose.*.yaml",
                            'compose.*.yml',
                        }, { upward = true })[1]),
                    })
                end,
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'php',
                callback = function()
                    local config = {
                        name = 'intelephense',
                        cmd = { 'intelephense', '--stdio' },
                        root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'composer.json' }, { upward = true })[1]),
                    }

                    vim.lsp.start(config, {
                        reuse_client = function(client, conf)
                            return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
                        end,
                    })
                end,
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'json,jsonc',
                callback = function()
                    local config = {
                        name = 'jsonls',
                        cmd = { 'vscode-json-language-server', '--stdio' },
                        root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
                    }

                    vim.lsp.start(config, {
                        reuse_client = function(client, conf)
                            return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
                        end,
                    })
                end,
            })

            vim.api.nvim_create_autocmd('FileType', {
                -- https://github.com/olrtg/emmet-language-server
                pattern = 'css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact',
                callback = function()
                    local config = {
                        name = 'emmet-language-server',
                        cmd = { 'emmet-language-server', '--stdio' },
                        root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
                        init_options = {
                            --- @type string[]
                            excludeLanguages = {},
                            --- @type string[]
                            extensionsPath = {},
                            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                            preferences = {},
                            --- @type boolean Defaults to `true`
                            showAbbreviationSuggestions = true,
                            --- @type "always" | "never" Defaults to `"always"`
                            showExpandedAbbreviation = 'always',
                            --- @type boolean Defaults to `false`
                            showSuggestionsAsSnippets = false,
                            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                            syntaxProfiles = {},
                            --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                            variables = {},
                        },
                    }

                    vim.lsp.start(config, {
                        reuse_client = function(client, conf)
                            return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
                        end,
                    })
                end,
            })

            vim.api.nvim_create_autocmd('FileType', {
                --  https://github.com/antonk52/cssmodules-language-server
                pattern = 'javascript,javascriptreact,typescript,typescriptreact',
                callback = function()
                    local config = {
                        name = 'cssmodules-language-server',
                        cmd = { 'cssmodules-language-server' },
                        root_dir = vim.fs.dirname(vim.fs.find({ 'package.json' }, { upward = true })[1]),
                        init_options = {
                            --- @type boolean|string `true|false` or `dashes` (defaults to `false`)
                            camelCase = false,
                        },
                    }

                    vim.lsp.start(config, {
                        reuse_client = function(client, conf)
                            return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
                        end,
                    })
                end,
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
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
                callback = function()
                    local get_root_dir = function(fname)
                        local util = require('lspconfig.util')
                        local root_file = {
                            '.eslintrc',
                            '.eslintrc.js',
                            '.eslintrc.cjs',
                            '.eslintrc.yaml',
                            '.eslintrc.yml',
                            '.eslintrc.json',
                            'eslint.config.js',
                        }

                        root_file = util.insert_package_json(root_file, 'eslintConfig', fname)
                        return util.root_pattern(unpack(root_file))(fname)
                    end

                    local config = {
                        name = 'eslint-language-server',
                        cmd = { 'vscode-eslint-language-server', '--stdio' },
                        root_dir = get_root_dir(),
                    }

                    vim.lsp.start(config, {
                        reuse_client = function(client, conf)
                            return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
                        end,
                    })
                end,
            })

            for _, server in ipairs({
                'neodev',
            }) do
                require('lsp.' .. server).setup(on_attach, capabilities)
            end
        end,
    },
}
