-- global settings
local indent = 4
vim.opt.shiftwidth = indent
vim.opt.tabstop = indent
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.o.cursorlineopt = 'screenline,number'
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.undodir = vim.fn.expand('~') .. '/.local/share/nvim/undo'
vim.opt.shortmess = 'filnxtToOFWIcC'
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.shiftround = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.inccommand = 'nosplit'
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.showbreak = '↪'
vim.opt.guifont = 'FiraCode Nerd Font Regular'
vim.opt.termguicolors = true
vim.opt.colorcolumn = '120'
vim.opt.pumheight = 25
vim.opt.pumblend = 10
vim.opt.shada = "!,'100,<50,s10,h,:1000,/1000"
vim.opt.redrawtime = 3000
vim.opt.clipboard = 'unnamedplus'
vim.opt.joinspaces = false
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.wildignore:append(
    '*.png,*.jpg,*.jpeg,*.gif,*.wav,*.aiff,*.dll,*.pdb,*.mdb,*.so,*.swp,*.zip,*.gz,*.bz2,*.meta,*.svg,*.cache,*/.git/*'
)
vim.opt.completeopt = { 'menuone', 'noinsert', 'preview' }
vim.opt.completetimeout = 100 -- Limit sources delay
vim.opt.autowrite = true
vim.opt.confirm = true
vim.opt.winwidth = 10
vim.go.winborder = 'rounded'
vim.opt.updatetime = 100
vim.opt.equalalways = true
vim.opt.backup = true
vim.opt.cmdheight = 0
vim.opt.backupdir = vim.fn.stdpath('state') .. '/backup'
vim.opt.smoothscroll = true
vim.opt.scrollbind = false
vim.opt.sessionoptions = {
    'buffers',
    'curdir',
    'folds',
    'tabpages',
    'winsize',
    'winpos',
}
vim.opt.conceallevel = 2
vim.opt.switchbuf = 'usetab'
vim.opt.splitkeep = 'screen'
vim.opt.formatoptions = 'rqnl1j'

vim.g.autosave_enabled = true
vim.g.maplocalleader = ','
vim.g.blink_enabled = true
vim.g.lsp_inlay_hints = false

-- taken from Lazyvim LazyVim/lua/lazyvim/plugins/extras/util/dot.lua
-- folding
vim.opt.foldenable = true
vim.opt.foldlevel = 10
vim.opt.foldnestmax = 10
vim.o.scrolloffpad = 1

local utils = require('utils')
vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
    callback = function(args)
        utils.set_folds(args.buf)
    end,
})

require('vim._core.ui2').enable({
    enable = true,
    msg = {
        targets = {
            [''] = 'msg',
            empty = 'cmd',
            confirm = 'cmd',
            completion = 'cmd',
            search_cmd = 'cmd',
            search_count = 'cmd',
            wildlist = 'cmd',
            typed_cmd = 'cmd',
        },

        cmd = {
            kind = 'floating',
            anchor = 'center',
            width = 0.6,
            height = 0.2,
        },

        dialog = {
            kind = 'floating',
            anchor = 'center',
            width = 0.5,
            height = 0.3,
        },

        msg = {
            kind = 'floating',
            anchor = 'cursor',
            height = 0.3,
            timeout = 5000,
        },

        pager = {
            kind = 'floating',
            anchor = 'center',
            width = 0.8,
            height = 0.6,
        },
    },
})
