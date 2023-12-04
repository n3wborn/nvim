vim.g.mapleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('custom')
require('lazy').setup('plugins')

require('custom.keymaps')
require('custom.autocommands')
