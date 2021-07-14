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


require('packer').startup(function()

    local use = require('packer').use

    -- Plugin manager
    use 'wbthomason/packer.nvim'


    --- Lsp
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'ray-x/lsp_signature.nvim'
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use 'onsails/lspkind-nvim'
    use 'folke/trouble.nvim'


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
        'nvim-telescope/telescope-project.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
        }
    }


    --- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        'nvim-treesitter/playground',
        after = "nvim-treesitter"
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = "nvim-treesitter"
    }


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
    use 'norcalli/nvim-colorizer.lua'
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-repeat'


    -- Git
    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim'
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }


    -- File explorer
    use 'kyazdani42/nvim-tree.lua'


    -- Colors and nice stuff
    use 'shaunsingh/nord.nvim'
    use 'marko-cerovac/material.nvim'
    use 'kyazdani42/nvim-web-devicons'


    -- Statusline
    use {
    'hoob3rt/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    }


    -- Div
    use 'lukas-reineke/indent-blankline.nvim'
    use 'farmergreg/vim-lastplace'

end
)

-- plugins with "simple" setup function
-- (and don't have their one config files)
require('nvim-autopairs').setup()

require("nvim-autopairs.completion.compe").setup({
    map_cr = true,        -- nvim-compe
    map_complete = true,
    check_ts = true,      -- treesitter
})

require('colorizer').setup {'css', 'javascript', 'html', 'twig'}
