-- From https://github.com/saikocat/dotfiles/blob/master/neovim/.config/nvim/lua/plugins/code/treesitter.lua
-- Treesitter textobjects dependency is a local plugin but proxied to nvim-treesitter-textobjects
-- this is to improve readibility iin the treesitter dependencies.
--
-- To recompile everything, delete all from these 2 directories:
--   * ~/.local/share/nvim/site/parser/
--   * ~/.local/share/nvim/site/queries/
--
-- Additional Refs:
--   * https://github.com/ThorstenRhau/neovim/blob/main/lua/optional/treesitter.lua

return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-context',
                opts = {
                    max_lines = 4,
                    multiline_threshold = 2,
                },
            },
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                branch = 'main',
                init = function()
                    -- Disable entire built-in ftplugin mappings to avoid conflicts.
                    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
                    vim.g.no_plugin_maps = true

                    -- Or, disable per filetype (add as you like)
                    -- vim.g.no_python_maps = true
                    -- vim.g.no_ruby_maps = true
                    -- vim.g.no_rust_maps = true
                    -- vim.g.no_go_maps = true
                end,

                config = function()
                    require('config.treesitter_textobjects_keymaps').setup()
                end,
            },
            {
                'JoosepAlviste/nvim-ts-context-commentstring',
                opts = {
                    enable_autocmd = false,
                },
            },
        },
        event = {
            'BufReadPre',
            'BufNewFile',
        },
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local ts = require('nvim-treesitter')
            ts.install({
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
                'ron',
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
            }, {
                max_jobs = 8,
            })

            local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

            local ignore_filetypes = {
                'blink-cmp-menu',
                'checkhealth',
                'fidget',
                'incline',
                'lazy',
                'lazy_backdrop',
                'mason',
                'mason_backdrop',
                'noice',
                'snacks_dashboard',
                'snacks_layout_box',
                'snacks_notif',
                'snacks_notif_history',
                'snacks_picker_input',
                'snacks_picker_list',
                'snacks_picker_preview',
                'snacks_terminal',
                'snacks_win',
            }

            -- Auto-install parsers and enable highlighting on FileType
            vim.api.nvim_create_autocmd('FileType', {
                group = group,
                desc = 'Enable treesitter highlighting and indentation',
                callback = function(event)
                    if vim.tbl_contains(ignore_filetypes, event.match) then
                        return
                    end

                    local lang = vim.treesitter.language.get_lang(event.match) or event.match
                    local buf = event.buf

                    -- Start highlighting immediately (works if parser exists)
                    pcall(vim.treesitter.start, buf, lang)

                    -- Enable treesitter indentation
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                    -- Install missing parsers (async, no-op if already installed)
                    ts.install({ lang })
                end,
            })
        end,
    },
}
