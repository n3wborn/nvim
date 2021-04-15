-- packer
--
-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	if vim.fn.input("download packer ? (y for yes)") ~= "y" then
		return
	end

	local directory = string.format(
	'%s/site/pack/packer/opt/',
	vim.fn.stdpath('data')
	)

	vim.fn.mkdir(directory, 'p')

	local git_clone_cmd = vim.fn.system(string.format(
	'git clone %s %s',
	'https://github.com/wbthomason/packer.nvim',
	directory .. '/packer.nvim'
	))

	print(git_clone_cmd)
	print("Installed packer.nvim...")

	return
end

return require('packer').startup(function()
	-- Packer can manage itself as an optional plugin
	use {'wbthomason/packer.nvim', opt = true}

	--- lsp
	use 'neovim/nvim-lspconfig'
	use 'neovim/nvim-lsp'
	use 'kabouzeid/nvim-lspinstall'
	use 'nvim-lua/lsp-status.nvim'
	use 'ojroques/nvim-lspfuzzy'

	--- telescope
	use {
	'nvim-telescope/telescope.nvim',
	requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}

	--- treesitter
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use 'nvim-treesitter/playground'
	use 'nvim-treesitter/nvim-treesitter-textobjects'

	-- fzf
	use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
	use 'junegunn/fzf.vim'

	--- code helpers
	use 'tpope/vim-commentary'
	use 'junegunn/vim-easy-align'
	use 'tpope/vim-surround'
	use 'mattn/emmet-vim'

	-- prettier/linter
	use 'prettier/vim-prettier'

	--- file explorer
	use 'kyazdani42/nvim-tree.lua'

	--- lang spec
	use 'ap/vim-css-color'
	use 'lumiliet/vim-twig'
	-- need to be fixed for lua
	-- use 'stephpy/vim-php-cs-fixer'
	-- use {'phpactor/phpactor', run = 'composer install'}

	use { 'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile' }

	--- git
	use 'tpope/vim-fugitive'
	use { 'lewis6991/gitsigns.nvim',
		config = require'plugins.gitsigns',
		requires = { 'nvim-lua/plenary.nvim' }
	}

	--- Completion
	use 'hrsh7th/nvim-compe'

	--- Snippets
	use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/vim-vsnip-integ'

	--- Colors and nice stuff
	use 'morhetz/gruvbox'
	use 'flazz/vim-colorschemes'
	use 'ryanoasis/vim-devicons'
	use 'kyazdani42/nvim-web-devicons'
	use 'itchyny/lightline.vim'

end)

