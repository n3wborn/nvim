-- https://github.com/nvim-treesitter/nvim-treesitter-context
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
    event = { 'BufEnter', 'BufNewFile' },
    lazy = false,
    build = ':TSUpdate',
    config = function()
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

        require('nvim-treesitter').install(languages, { max_jobs = 8 }):wait(300000) -- wait max. 5 minutes

        local init = vim.api.nvim_get_runtime_file('lua/nvim-treesitter/init.lua', false)[1]
        if init then
            vim.opt.runtimepath:prepend(vim.fn.fnamemodify(init, ':h:h:h') .. '/runtime')
        end

        require('nvim-treesitter').install(languages):wait(300000)
    end,
}
