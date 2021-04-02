--- Settings

local o = vim.o 	-- global options
local wo = vim.wo	-- window-scoped options
local bo = vim.bo	-- buffer-scoped options
local g = vim.g 	-- a table to access global variables (let g:***)
local cmd = vim.cmd	-- vim.cmd({cmd}) invoc Ex command. vim.cmd('echo 42')
local indent = 4

bo.expandtab = true
bo.shiftwidth = indent
bo.smartindent = true
bo.tabstop = indent
bo.undofile = true

o.completeopt = 'menuone,preview'
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
o.incsearch = true
o.cmdheight = 2
o.showbreak = "↪"
o.listchars = "tab:→ ,eol:↲,nbsp:␣,trail:•,precedes:←,extends:→"
o.guifont = "Fira"
o.termguicolors = true
o.colorcolumn = "80"

wo.list = true
wo.number = true
wo.relativenumber = true
wo.wrap = false
wo.signcolumn = "yes"

g.php_cs_fixer_path = "~/prog/git/PHP_CodeSniffer/bin/phpcs"
g.php_cs_fixer_rules = "@PSR2"

g.nvim_tree_indent_markers = 1
g.nvim_tree_git_hl = 1


cmd('set shortmess+=c')			-- hide unwanted msg
cmd('colorscheme gruvbox')		-- colorscheme
cmd('highlight Normal guibg=NONE')	-- background


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
