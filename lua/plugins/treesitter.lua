-- heavily inspired by LazyVim/LazyVim config
return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                config = function()
                    -- When in diff mode, we want to use the default
                    -- vim text objects c & C instead of the treesitter ones.
                    local move = require('nvim-treesitter.textobjects.move') ---@type table<string,fun(...)>
                    local configs = require('nvim-treesitter.configs')
                    for name, fn in pairs(move) do
                        if name:find('goto') == 1 then
                            move[name] = function(q, ...)
                                if vim.wo.diff then
                                    local config = configs.get_module('textobjects.move')[name] ---@type table<string,string>
                                    for key, query in pairs(config or {}) do
                                        if q == query and key:find('[%]%[][cC]') then
                                            vim.cmd('normal! ' .. key)
                                            return
                                        end
                                    end
                                end
                                return fn(q, ...)
                            end
                        end
                    end
                end,
            },
            {
                'nvim-treesitter/nvim-treesitter-refactor',
            },
        },
        cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            auto_install = true,
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
                    border = _G.global.float_border_opts.border,
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
            refactor = {
                highlight_definitions = {
                    enable = true,
                    clear_on_cursor_move = true,
                },
                smart_rename = {
                    enable = true,
                    keymaps = {
                        smart_rename = 'grr',
                    },
                },
                navigation = {
                    enable = true,
                    keymaps = {
                        goto_definition = 'gnd',
                        list_definitions = 'gnD',
                        list_definitions_toc = 'gO',
                    },
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                ---@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require('nvim-treesitter.configs').setup(opts)
        end,
        -- config = function(_, opts)
        --     local ts = require('nvim-treesitter.configs')
        --     ts.setup(opts)
        -- end,
    },
    {
        'windwp/nvim-ts-autotag',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
    },
}
