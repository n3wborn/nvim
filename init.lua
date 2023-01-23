-- global settings
local indent = 4
local opt = vim.opt

opt.shiftwidth = indent
opt.tabstop = indent
opt.expandtab = true
opt.smartindent = true
opt.undofile = true
opt.cursorline = true
opt.list = true
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = 'indent'
opt.signcolumn = 'yes'
vim.opt.numberwidth = 3
vim.opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"
opt.shortmess = 'filnxtToOFWIcC'
opt.hidden = true
opt.ignorecase = true
opt.joinspaces = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.shiftround = true
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 50
opt.inccommand = 'nosplit'
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.cmdheight = 1
opt.guifont = 'FiraCode Nerd Font Regular'
opt.termguicolors = true
opt.colorcolumn = '120'
opt.pumheight = 25
opt.pumblend = 10
opt.shada = "!,'100,<50,s10,h,:1000,/1000"
opt.lazyredraw = true
opt.redrawtime = 3000
opt.clipboard = 'unnamedplus'
opt.joinspaces = false
vim.o.undodir = vim.fn.expand('~') .. '/.local/share/nvim/undo'
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local builtins = {
    'gzip',
    'zip',
    'zipPlugin',
    'fzf',
    'tar',
    'tarPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'matchit',
    'matchparen',
    'logiPat',
    'rrhelper',
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
}

for _, plugin in ipairs(builtins) do
    vim.g['loaded_' .. plugin] = 1
end

vim.g.mapleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('modules.core')
require('modules.lsp')
require('modules.plugins')
