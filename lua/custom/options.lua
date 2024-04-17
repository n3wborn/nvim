-- global settings
local indent = 4
vim.opt.shiftwidth = indent
vim.opt.tabstop = indent
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number' --- @todo: use a fn to hide if new empty buffer
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'
vim.opt.undodir = vim.fn.expand('~') .. '/.local/share/nvim/undo'
vim.opt.shortmess = 'filnxtToOFWIcC'
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
vim.opt.showbreak = '↪'
vim.opt.guifont = 'FiraCode Nerd Font Regular'
vim.opt.termguicolors = true
vim.opt.colorcolumn = '120'
vim.opt.pumheight = 25
vim.opt.pumblend = 10
vim.opt.shada = "!,'100,<50,s10,h,:1000,/1000"
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'indent'
vim.opt.redrawtime = 3000
vim.opt.clipboard = 'unnamedplus'
vim.opt.joinspaces = false
vim.opt.updatetime = 250
vim.opt.wildmode = 'longest:full,full'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.autowrite = true
vim.opt.confirm = true
vim.g.markdown_recommended_style = 0

vim.wo.foldtext = 'v:lua.vim.treesitter.foldtext()'

-- taken from Lazyvim LazyVim/lua/lazyvim/plugins/extras/util/dot.lua
vim.filetype.add({
    extension = { rasi = 'rasi', rofi = 'rasi', wofi = 'rasi' },
    filename = {
        ['.env'] = 'dotenv',
        ['vifmrc'] = 'vim',
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

if vim.fn.has('nvim-0.8') == 1 then
    vim.opt.backup = true
    vim.opt.cmdheight = 0
    vim.opt.backupdir = vim.fn.stdpath('state') .. '/backup'
end

if vim.fn.has('nvim-0.10') == 1 then
    vim.opt.smoothscroll = true
end
