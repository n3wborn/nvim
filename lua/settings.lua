-- global settings
_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

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
vim.g.live_previewer_enabled = false
vim.g.markdown_preview_enabled = not vim.g.live_previewer_enabled
vim.g.maplocalleader = ','
vim.g.blink_enabled = true
vim.g.lsp_inlay_hints = false

-- taken from Lazyvim LazyVim/lua/lazyvim/plugins/extras/util/dot.lua
-- folding
vim.opt.foldenable = true
vim.opt.foldlevel = 10
vim.opt.foldnestmax = 10

--- MariaSolOs config

local arrows = require('icons').arrows

-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Use an indentation of 4 spaces.
vim.o.sw = 4
vim.o.ts = 4
vim.o.et = true

-- Show whitespace.
vim.opt.list = true
vim.opt.listchars = { space = '⋅', trail = '⋅', tab = '  ↦' }

-- Show line numbers.
vim.wo.number = true

-- Enable mouse mode.
vim.o.mouse = 'a'

-- Disable horizontal scrolling.
vim.o.mousescroll = 'ver:3,hor:0'

-- Wrap long lines at words.
vim.o.linebreak = true

-- Folding.
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''

-- UI characters.
vim.opt.fillchars = {
    eob = ' ',
    fold = ' ',
    foldclose = arrows.right,
    foldopen = arrows.down,
    foldsep = ' ',
    foldinner = ' ',
    msgsep = '─',
}

-- Use rounded borders for floating windows.
vim.o.winborder = 'rounded'

-- Sync clipboard between the OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Silence `wl-paste`'s "Nothing is copied" stderr on an empty Wayland clipboard.
if vim.fn.has('linux') == 1 and vim.env.WAYLAND_DISPLAY then
    vim.g.clipboard = {
        name = 'wl-clipboard',
        copy = {
            ['+'] = 'wl-copy --type text/plain',
            ['*'] = 'wl-copy --primary --type text/plain',
        },
        paste = {
            ['+'] = { 'sh', '-c', 'wl-paste --no-newline 2>/dev/null || true' },
            ['*'] = { 'sh', '-c', 'wl-paste --primary --no-newline 2>/dev/null || true' },
        },
        cache_enabled = true,
    }
end

-- Save undo history.
vim.o.undofile = true

-- Enable project-local configuration.
vim.o.exrc = true

-- Case insensitive searching UNLESS /C or the search has capitals.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default.
vim.wo.signcolumn = 'yes'

-- Update times and timeouts.
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

-- Completion.
vim.opt.wildignore:append({ '.DS_Store' })
vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.pumheight = 15
vim.o.pumborder = 'rounded'

-- Diff mode settings.
-- Setting the context to a very large number disables folding.
vim.opt.diffopt:append('followwrap,vertical,context:99')

vim.opt.shortmess:append({
    w = true,
    s = true,
})

-- Status line.
vim.o.laststatus = 3
vim.o.cmdheight = 1

-- Disable cursor blinking in terminal mode.
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor'

-- Disable health checks for these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
