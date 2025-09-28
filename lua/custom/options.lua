-- global settings
local indent = 4
vim.opt.shiftwidth = indent
vim.opt.tabstop = indent
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.o.cursorlineopt = 'both'
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
vim.opt.completeopt = { 'menuone', 'fuzzy', 'noinsert', 'preview' }
vim.opt.autowrite = true
vim.opt.confirm = true
vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.g.markdown_recommended_style = 0
vim.g.maplocalleader = ','
vim.wo.foldtext = 'v:lua.vim.treesitter.foldtext()'
vim.o.winborder = 'rounded'
vim.o.statuscolumn = '%@SignCb@%s%=%T%@NumCb@%l│%T'
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

vim.g.blink_enabled = true
vim.g.nvim_cmp_enabled = not vim.g.blink_enabled
vim.g.lsp_inlay_hints = false
vim.g.copilot_enabled = false
vim.g.cursor_enabled = false

-- taken from Lazyvim LazyVim/lua/lazyvim/plugins/extras/util/dot.lua
vim.filetype.add({
    extension = { rasi = 'rasi', rofi = 'rasi', wofi = 'rasi' },
    filename = {
        ['.env'] = 'dotenv',
        ['vifmrc'] = 'vim',
        log = 'log',
        conf = 'conf',
    },
    pattern = {
        ['.*twig'] = 'twig.html',
        ['.*/waybar/config'] = 'jsonc',
        ['.*/mako/config'] = 'dosini',
        ['.*/kitty/*.conf'] = 'bash',
        ['.*/hypr/.*%.conf'] = 'hyprlang',
        ['%.env%.[%w_.-]+'] = 'dotenv',
    },
})
