local execute      = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local fn           = vim.fn


-- install packer if needed
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
    augroup Packer
        autocmd!
        autocmd BufWritePost plugins.lua PackerCompile
    augroup end
]], false)


local use = require('packer').use
require('packer').startup({function()

    -- Plugin manager
    use 'wbthomason/packer.nvim'

    --- Lsp
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'ray-x/lsp_signature.nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use 'onsails/lspkind-nvim'
    use 'glepnir/lspsaga.nvim'

    -- Completion
    use 'hrsh7th/nvim-compe'

    -- Snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    --- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim'
        }
    }

    use {
        'nvim-telescope/telescope-media-files.nvim',
        requires = {
            'nvim-telescope/telescope.nvim'
        }
    }

    --- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Fzf
    use {
        'junegunn/fzf',
        dir = '~/.fzf',
        run = './install --all'
    }
    use 'junegunn/fzf.vim'

    -- Dev div tools
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-commentary'
    use 'junegunn/vim-easy-align'
    use 'tpope/vim-surround'
    use 'mattn/emmet-vim'
    use 'lumiliet/vim-twig'
    use 'norcalli/nvim-colorizer.lua'
    use 'windwp/nvim-autopairs'

    -- Prettier/Linter
    use 'prettier/vim-prettier'

    -- Git
    use 'tpope/vim-fugitive'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- File explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Colors and nice stuff
    use "murilo-menezes/palenight.lua"
    use 'kyazdani42/nvim-web-devicons'

    -- Statusline
    use 'famiu/feline.nvim'

    -- Div
    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = 'lua'
    }
    use 'farmergreg/vim-lastplace'

end,

config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}
})


--- lua files
require('colorscheme')
require('functions')
require('mappings')
require('settings')
require('statusline')
require('utils')

require('config.autocommands')
require('config.lsp')
require('config.telescope-nvim-utils')


--required plugins
require('plugins.autopairs')
require('plugins.blankline')
require('plugins.colorizer')
require('plugins.compe')
require('plugins.gitsigns')
require('plugins.lspsaga')
require('plugins.nvim-tree')
require('plugins.telescope')
require('plugins.treesitter')

