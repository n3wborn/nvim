local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'


if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end


vim.api.nvim_exec([[
    augroup Packer
        autocmd!
        autocmd BufWritePost plugins.lua PackerCompile
    augroup end
]], false)


local use = require('packer').use
require('packer').startup(function()

    -- Packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim' }

    --- Lsp
    use 'neovim/nvim-lspconfig'
    use 'neovim/nvim-lsp'
    use 'ray-x/lsp_signature.nvim'
    use 'kabouzeid/nvim-lspinstall'
    use 'nvim-lua/lsp-status.nvim'

    --- Telescope
    use { 'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/popup.nvim'} , { 'nvim-lua/plenary.nvim' }
        }
    }

    --- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Fzf
    use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
    use 'junegunn/fzf.vim'

    --- Code helpers
    use 'tpope/vim-commentary'
    use 'junegunn/vim-easy-align'
    use 'tpope/vim-surround'
    use 'mattn/emmet-vim'
    use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua'}


    -- Prettier/Linter
    use 'prettier/vim-prettier'

    --- File explorer
    use 'kyazdani42/nvim-tree.lua'

    --- Lang spec
    use 'ap/vim-css-color'
    use 'lumiliet/vim-twig'
    -- need to be fixed for lua
    -- use 'stephpy/vim-php-cs-fixer'
    -- use {'phpactor/phpactor', run = 'composer install'}

    use { 'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile' }

    --- Completion
    use 'hrsh7th/nvim-compe'

    --- Snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    --- Git
    use 'tpope/vim-fugitive'
    use { 'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    --- Colors and nice stuff
    use 'morhetz/gruvbox'
    use 'flazz/vim-colorschemes'
    -- use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'

    -- feline statusline
    use 'famiu/feline.nvim'

    -- Div
    use 'editorconfig/editorconfig-vim'
    use 'farmergreg/vim-lastplace'

end)


--- lua folder required files
require('config')
require('functions')
require('mappings')
require('settings')
require('statusline')
require('utils')
require('plugins')
