local o = vim.opt
local fn = vim.fn

-- global settings
o.shiftwidth = 4
o.tabstop = 4
o.expandtab = true
o.undofile = true
o.cursorline = true
o.list = true
o.number = true
o.relativenumber = true
o.wrap = false
o.signcolumn = 'yes'
o.undodir = fn.expand('~') .. '/.local/share/nvim/undo'
o.hidden = true
o.ignorecase = true
o.joinspaces = false
o.scrolloff = 8
o.sidescrolloff = 8
o.shiftround = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.wildmode = 'list:longest'
o.updatetime = 50
o.inccommand = 'nosplit'
o.errorbells = false
o.swapfile = false
o.backup = false
o.cmdheight = 1
o.showbreak = '↪'
o.guifont = 'Fira'
o.termguicolors = true
o.colorcolumn = '120'
o.pumheight = 25
o.pumblend = 10
o.shada = "!,'100,<50,s10,h,:1000,/1000"
o.lazyredraw = true
o.foldlevel = 99
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'

require('utils').setup_config({
    'autocommands',
    'colorscheme',
    'mappings',
    'lsp',
    'statusline',
})
