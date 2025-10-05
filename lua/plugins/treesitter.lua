-- heavily inspired by LazyVim/LazyVim config
return {
    ---@type LazyPluginSpec
    {

        'nvim-treesitter/nvim-treesitter',
        version = false, -- last release is way too old and doesn't work on Windows
        build = ':TSUpdate',
        event = { 'VeryLazy' },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require('lazy.core.loader').add_to_rtp(plugin)
            require('nvim-treesitter.query_predicates')
        end,
        cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall', 'TSContext' },
        keys = {
            { '<c-space>', desc = 'Increment Selection' },
            { '<bs>', desc = 'Decrement Selection', mode = 'x' },
        },
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            indent = { enable = true },
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
            },
            incremental_selection = {
                enable = true,
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
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = 'VeryLazy',
        enabled = true,
        config = function()
            local textobjects = {
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
            }
            require('nvim-treesitter.configs').setup({ textobjects = textobjects })
        end,
    },
    ---@type LazyPluginSpec
    {
        'windwp/nvim-ts-autotag',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
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
