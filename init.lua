-- experimental Lua module loader.
vim.loader.enable()

vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.cmd.colorscheme('catpuccin')

require('settings')
require('keymaps')

vim.cmd.packadd('nvim.undotree')

require('vim._core.ui2').enable({})
