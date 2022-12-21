-- global settings
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'
vim.opt.undodir = vim.fn.expand('~') .. '/.local/share/nvim/undo'
vim.opt.shortmess:append('cS')
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.shiftround = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 50
vim.opt.inccommand = 'nosplit'
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.cmdheight = 1
vim.opt.showbreak = '↪'
vim.opt.guifont = 'Fira'
vim.opt.termguicolors = true
vim.opt.colorcolumn = '120'
vim.opt.pumheight = 25
vim.opt.pumblend = 10
vim.opt.shada = "!,'100,<50,s10,h,:1000,/1000"
vim.opt.lazyredraw = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'indent'
vim.opt.redrawtime = 3000
vim.g.mapleader = ','

_G.global = {}

-- diagnostics
local border_opts = { border = 'rounded', focusable = false, scope = 'line' }

vim.diagnostic.config({ virtual_text = false, float = border_opts })
vim.fn.sign_define('DiagnosticSignError', { text = '✗', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '!', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInformation', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

require('modules.core')
require('modules.lsp')
require('modules.plugins')
