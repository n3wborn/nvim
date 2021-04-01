--- Settings

local o = vim.o		-- global options
local wo = vim.wo	-- window-scoped options
local bo = vim.bo	-- buffer-scoped options

local indent = 4

bo.expandtab = true
bo.shiftwidth = indent
bo.smartindent = true
bo.tabstop = indent
bo.undofile = true

o.completeopt = 'menuone,noinsert,noselect'
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
o.updatetime = 200
o.inccommand = 'nosplit'
o.errorbells = false
o.swapfile = false
o.backup = false
o.incsearch = true
o.cmdheight = 2
o.showbreak = "↪"
o.listchars = "tab:→ ,eol:↲,nbsp:␣,trail:•,precedes:←,extends:→"
o.guifont = "Fira"
o.termguicolors = true
--- o.background = "none"

wo.list = true
wo.number = true
wo.relativenumber = true
wo.wrap = false
wo.signcolumn = "yes"
-- wo.colorcolumn = "lightgrey"

-- colorscheme(s)
vim.cmd('colorscheme gruvbox')

-- div

-- no need for a global function
local set_options = function(locality,options)
    for key, value in pairs(options) do
        locality[key] = value
    end
end

local options_window = {
    cursorline = true -- enable cursorline
}

--set locally. no need to call elsewhere
set_options(o,options_window)
