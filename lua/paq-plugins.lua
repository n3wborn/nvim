-- paq minimalist plugin manager  (https://github.com/savq/paq-nvim.git)

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()

--- Plugins
cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself


--- lsp
paq {'neovim/nvim-lspconfig'}
paq {'neovim/nvim-lsp'}
paq {'kabouzeid/nvim-lspinstall'}
paq {'nvim-lua/lsp-status.nvim'}

--- telescope treesitter
paq {'nvim-telescope/telescope.nvim'}
paq {'nvim-treesitter/nvim-treesitter', hook = fn[':TSUpdate']}
paq {'nvim-treesitter/playground'}
paq {'nvim-treesitter/nvim-treesitter-textobjects'}
paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}

--- completion
paq {'nvim-lua/completion-nvim'}

--- fuzzy
paq {'junegunn/fzf', hook = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'ojroques/nvim-lspfuzzy'}

--- coc
paq {'neoclide/coc.nvim', branch = 'release'}

--- code helpers
paq {'tpope/vim-commentary'}
paq {'junegunn/vim-easy-align'}
paq {'tpope/vim-surround'}
paq {'tpope/vim-endwise'}
paq {'mhinz/vim-mix-format'}

-- prettier/linter
paq {'prettier/vim-prettier'}

--- file explorer
paq {'kyazdani42/nvim-tree.lua'}

--- lang spec
paq {'ap/vim-css-color'}
paq {'evidens/vim-twig'}
paq {'stephpy/vim-php-cs-fixer'}

--- git
paq {'tpope/vim-fugitive'}
paq {'airblade/vim-gitgutter'}
--paq {'ewis6991/gitsigns.nvim'}

--- Snippets
paq {'SirVer/ultisnips'}
paq {'honza/vim-snippets'}

--- Undo stuff
paq {'mbbill/undotree'}

--- Colors and nice stuff
paq {'morhetz/gruvbox'}
paq {'flazz/vim-colorschemes'}
paq {'ryanoasis/vim-devicons'}
paq {'kyazdani42/nvim-web-devicons'}
--paq {'hoob3rt/lualine.nvim', opt = true}
