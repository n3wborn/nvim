vim.g.mapleader = ','
vim.g.maplocalleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

local disabled_builtins = {
    'gzip',
    'matchit',
    'matchparen',
    'netrwPlugin',
    'tarPlugin',
    'tohtml',
    'tutor',
    'zipPlugin',
}

for _, plugin in ipairs(disabled_builtins) do
    vim.g['loaded_' .. plugin] = 1
end

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
        ---@type LazyPluginSpec
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'b0o/SchemaStore.nvim',
            },
            event = { 'BufReadPre', 'BufNewFile' },
        },
        ---@type LazyPluginSpec
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
        ---@type LazyPluginSpec
        {
            'kylechui/nvim-surround',
            event = 'VeryLazy',
        },
        ---@type LazyPluginSpec
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
        colorscheme = { 'catppuccin' },
    },
    checker = { enabled = true },
    rocks = { enabled = false },
})

vim.cmd.colorscheme('catppuccin-mocha')

require('config')
