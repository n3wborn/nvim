vim.g.mapleader = ','
vim.g.maplocalleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'plugins' },
        { import = 'plugins.extras.lang' },
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'b0o/SchemaStore.nvim',
            },
            event = { 'BufReadPre', 'BufNewFile' },
        },
        {
            'mbbill/undotree',
            keys = {
                {
                    '<leader>U',
                    '<cmd>UndotreeToggle<cr>',
                    desc = 'Toggles undotree',
                },
            },
        },
        {
            'kylechui/nvim-surround',
            version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
            event = 'VeryLazy',
            config = function()
                require('nvim-surround').setup()
            end,
        },
        ---@type LazyPluginSpec
        {
            'HiPhish/rainbow-delimiters.nvim',
            event = 'VeryLazy',
        },
        {

            'nvzone/typr',
            dependencies = 'nvzone/volt',
            opts = {},
            cmd = { 'Typr', 'TyprStats' },
        },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    install = {
        missing = true,
        colorscheme = { 'catpuccin' },
    },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
    ui = { border = 'rounded' },
})

require('config')
