-- heavily inspired by LazyVim/LazyVim config
return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        build = ':TSUpdate',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            local configs = require('nvim-treesitter.configs')
            local ensure_installed = {
                'awk',
                'bash',
                'c',
                'cmake',
                'css',
                'diff',
                'dockerfile',
                'dot',
                'gitattributes',
                'gitcommit',
                'gitignore',
                'go',
                'html',
                'http',
                'java',
                'javascript',
                'jq',
                'jsdoc',
                'json',
                'lua',
                'make',
                'markdown',
                'markdown_inline',
                'perl',
                'php',
                'phpdoc',
                'php_only',
                'python',
                'query',
                'regex',
                'ruby',
                'rust',
                'scss',
                'solidity',
                'sql',
                'styled',
                'svelte',
                'toml',
                'tsx',
                'twig',
                'typescript',
                'vim',
                'vimdoc',
                'vue',
                'yaml',
            }

            configs.setup({
                ensure_installed = ensure_installed,
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = false },
                incremental_selection = {
                    enable = false,
                    keymaps = {
                        init_selection = '<C-space>',
                        node_incremental = '<C-space>',
                        scope_incremental = false,
                        node_decremental = '<bs>',
                    },
                },
                textobjects = {
                    lookahead = true,
                    lsp_interop = {
                        enable = true,
                        border = 'rounded',
                        peek_definition_code = {
                            ['df'] = '@function.outer',
                            ['dF'] = '@class.outer',
                        },
                    },
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            ['aC'] = '@comment.outer',
                            ['iC'] = '@comment.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                },
            })
        end,
    },
    ---@type LazyPluginSpec
    {
        'windwp/nvim-ts-autotag',
        event = 'VeryLazy',
        opts = {},
    },
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
        cmd = { 'TSContext' },
        opts = function()
            local tsc = require('treesitter-context')
            Snacks.toggle({
                name = 'Treesitter Context',
                get = tsc.enabled,
                set = function(state)
                    if state then
                        tsc.enable()
                    else
                        tsc.disable()
                    end
                end,
            }):map('<leader>ut')

            return {
                max_lines = 3,
            }
        end,
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
    },
}
