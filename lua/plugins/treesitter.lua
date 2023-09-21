return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'windwp/nvim-ts-autotag',
            'nvim-treesitter/nvim-treesitter-refactor',
        },
        config = function()
            pcall(require('nvim-treesitter.install').update({ with_sync = true }))

            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'awk',
                    'bash',
                    'c',
                    'cmake',
                    'css',
                    'diff',
                    'dockerfile',
                    'dot',
                    'gitattributes',
                    'gitignore',
                    'go',
                    'html',
                    'java',
                    'javascript',
                    'jq',
                    'jsdoc',
                    'json',
                    'lua',
                    'make',
                    'markdown',
                    'perl',
                    'php',
                    'phpdoc',
                    'python',
                    'query',
                    'regex',
                    'ruby',
                    'rust',
                    'scss',
                    'solidity',
                    'sql',
                    'svelte',
                    'toml',
                    'tsx',
                    'twig',
                    'typescript',
                    'vim',
                    'vue',
                    'yaml',
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
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
                autotag = { enable = true },
                refactor = {
                    highlight_definitions = { enable = true },
                    clear_on_cursor_move = true,
                },
            })
        end,
    },
}
