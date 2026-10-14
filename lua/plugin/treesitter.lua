-- https://github.com/nvim-treesitter/nvim-treesitter-context
--
-- To recompile everything, delete all from these 2 directories:
--   * ~/.local/share/nvim/site/parser/
--   * ~/.local/share/nvim/site/queries/
--
-- Additional Refs:
--   * https://github.com/ThorstenRhau/neovim/blob/main/lua/optional/treesitter.lua

local vim_pack = require('vim-pack')

vim_pack.on_plugin_update('nvim-treesitter', function(data)
    if not data.active then
        vim.cmd.packadd('nvim-treesitter')
    end
    vim.cmd('TSUpdate')
end)

vim_pack.add_on_event({ 'BufReadPost', 'BufNewFile' }, {
    {
        src = 'nvim-treesitter/nvim-treesitter',
        version = 'main',
        setup = false,
        on_setup = function()
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
                'git_config',
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
                'xml',
                'yaml',
                'zig',
            }

            -- Async: already installed parsers are skipped, missing ones are installed in background
            require('nvim-treesitter').install(languages, { max_jobs = 8 })

            -- Folding is handled in config/folding.lua
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
                callback = function(args)
                    local buf = args.buf
                    local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype) or vim.bo[buf].filetype
                    pcall(vim.treesitter.start, buf, lang)
                end,
            })
        end,
    },
})
