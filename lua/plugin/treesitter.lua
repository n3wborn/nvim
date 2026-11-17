-- https://github.com/nvim-treesitter/nvim-treesitter-context
--
-- To recompile everything, delete all from these 2 directories:
--   * ~/.local/share/nvim/site/parser/
--   * ~/.local/share/nvim/site/queries/
--
-- Additional Refs:
--   * https://github.com/ThorstenRhau/neovim/blob/main/lua/optional/treesitter.lua

local vim_pack = require('vim-pack')

local function install_list()
    local parsers = {
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

    local set = {}
    for _, parser in ipairs(parsers) do
        set[parser] = true
    end

    local site = vim.fn.stdpath('data')
    for _, path in ipairs(vim.api.nvim_get_runtime_file('parser/*', true)) do
        -- Skip the parsers nvim-treesitter already installed under `site/`.
        if not vim.startswith(path, site) then
            set[vim.fn.fnamemodify(path, ':t:r')] = true
        end
    end

    return vim.tbl_keys(set)
end

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
        if args.data.spec.name == 'nvim-treesitter' and (args.data.kind == 'install' or args.data.kind == 'update') then
            -- Re-install and update parsers.
            require('nvim-treesitter').install(install_list()):wait(300001)
            require('nvim-treesitter').update():wait(300000)
        end
    end,
})

local add = require('vim-pack').add

add({
    {
        src = 'nvim-treesitter/nvim-treesitter',
        on_setup = function()
            -- Main-branch nvim-treesitter ships queries under `runtime/queries/`,
            -- which isn't on rtp by default. Prepend it so highlights/folds/indents
            -- are visible to `vim.treesitter.start`.
            local init = vim.api.nvim_get_runtime_file('lua/nvim-treesitter/init.lua', false)[1]
            if init then
                vim.opt.runtimepath:prepend(vim.fn.fnamemodify(init, ':h:h:h') .. '/runtime')
            end

            require('nvim-treesitter').install(install_list()):wait(300000)
        end,
    },
    {
        src = 'nvim-treesitter/nvim-treesitter-context',
        module_name = 'treesitter-context',
        opts = {
            -- Avoid the sticky context from growing a lot.
            max_lines = 3,
            -- Match the context lines to the source code.
            multiline_threshold = 1,
            -- Disable it when the window is too small.
            min_window_height = 20,
        },
        on_setup = function()
            vim.keymap.set('n', '[c', function()
                -- Jump to previous change when in diffview.
                if vim.wo.diff then
                    return '[c'
                else
                    vim.schedule(function()
                        require('treesitter-context').go_to_context()
                    end)
                    return '<Ignore>'
                end
            end, { desc = 'Jump to upper context', expr = true })
        end,
    },
})

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
        if args.data.spec.name == 'nvim-treesitter' and (args.data.kind == 'install' or args.data.kind == 'update') then
            -- Re-install and update parsers.
            require('nvim-treesitter').install(install_list()):wait(300000)
            require('nvim-treesitter').update():wait(300000)
        end
    end,
})
