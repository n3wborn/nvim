_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.sessions_enabled = true

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
    performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            disabled_plugins = {
                'gzip',
                'tarPlugin',
                'tohtml',
                'zipPlugin',
                'netrwPlugin',
                'matchit',
                'matchparen',
                'tutor',
            },
        },
    },
    spec = {
        { import = 'plugins' },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    install = {
        missing = true,
        colorscheme = { 'catppuccin' },
    },
    checker = { enabled = false },
    rocks = { enabled = false },
})

vim.cmd.colorscheme('catppuccin-mocha')

vim.cmd('packadd nvim.difftool')
vim.cmd('packadd nvim.undotree')

require('config')

vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden'
vim.opt.grepformat = '%f:%l:%c:%m'
