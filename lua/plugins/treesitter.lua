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

---@type LazyPluginSpec
return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-context',
            lazy = true,
            opts = {
                max_lines = 4,
                multiline_threshold = 2,
            },
        },
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            branch = 'main',
            lazy = true,
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
            lazy = false,
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
        local languages = {
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
        }

        require('nvim-treesitter').install(languages, { max_jobs = 8 })

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
            callback = function(args)
                local buf = args.buf
                -- Check if we have a parser for the current filetype
                local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype) or vim.bo[buf].filetype

                -- Try to start highlighting
                local ok, _ = pcall(vim.treesitter.start, buf, lang)

                if ok then
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end

                vim.opt.foldmethod = 'expr'
                vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            end,
        })
    end,
}
