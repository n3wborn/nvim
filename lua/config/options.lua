-- global settings
vim.g.blink_enabled = true
vim.g.lsp_inlay_hints = false

-- tabs / indent
local indent = 4
vim.o.shiftwidth = indent
vim.o.tabstop = indent
vim.o.expandtab = true
vim.o.smartindent = true

-- smart case search
vim.o.ignorecase = true
vim.o.smartcase = true

-- default "ltToOCF"
vim.opt.shortmess:append({
    w = true,
    s = true,
    I = true,
})

-- backup
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath('state') .. '/backup'

-- undo / swap
vim.o.undofile = true
vim.o.undodir = vim.fn.expand('~') .. '/.local/share/nvim/undo'
vim.o.swapfile = false

-- When jumping through the call stack, try to switch to the buffer
-- if already open in a window, else use the last window to open the buffer.
vim.o.switchbuf = 'usetab,uselast'

-- split
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = 'screen'
vim.o.equalalways = true

vim.o.shada = "!,'100,<50,s10,h,:1000,/1000"

-- use system clipboard
vim.o.clipboard = 'unnamedplus'

-- completion
vim.opt.completeopt = { 'menuone', 'noinsert', 'preview' }
vim.o.completetimeout = 100 -- Limit sources delay
vim.o.pumheight = 25
vim.o.pumblend = 10
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.wildignore:append(
    '*.png,*.jpg,*.jpeg,*.gif,*.wav,*.aiff,*.dll,*.pdb,*.mdb,*.so,*.swp,*.zip,*.gz,*.bz2,*.meta,*.svg,*.cache,*/.git/*'
)

-- auto read / write
vim.o.autoread = true
vim.o.autowrite = true
vim.o.autowriteall = true

-- fold
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 10
vim.wo.foldtext = ''

-- disable folding in diff
vim.opt.diffopt:append('followwrap,vertical,context:99')

-- format
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.g.autoformat = true

-- needed for tree-sitter aware commenting
vim.o.commentstring = ''

-- conceal
vim.o.conceallevel = 2

-- window
vim.o.winwidth = 10
vim.o.winborder = 'rounded'

-- line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false

-- update / redraw screen
vim.o.redrawtime = 3000
vim.o.updatetime = 100

-- show column limit
vim.o.colorcolumn = '120'

-- highligh screenline and numberline
vim.o.cursorlineopt = 'both'

-- gui
vim.o.guifont = 'FiraCode Nerd Font Regular'
vim.o.termguicolors = true

-- UI characters
vim.opt.fillchars:append({
    fold = ' ',
    foldopen = '',
    foldclose = '',
    foldsep = ' ',
})

-- show a ~ char on wrapped line
vim.o.showbreak = '↪'

-- Status line
vim.o.laststatus = 3
vim.o.cmdheight = 1

-- scroll
vim.o.smoothscroll = true
vim.o.scrollbind = false
vim.o.scrolloffpad = 1
