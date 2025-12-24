-- heavily inspired by LazyVim/LazyVim config
return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        build = ':TSUpdate',
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
    ---@type LazyPluginSpec
    {
        'HiPhish/rainbow-delimiters.nvim',
        event = 'VeryLazy',
    },
}
