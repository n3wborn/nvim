local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local fn = vim.fn

-- install packer if needed
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute('packadd packer.nvim')
end

require('packer').init({
    -- /home/stef/.local/share/nvim/site/pack/packer/start/packer.nvim/packer_compiled.lua
    compile_path = install_path .. '/packer_compiled.lua',
})

require('packer').startup(function()
    local use = require('packer').use

    -- Plugin manager
    use('wbthomason/packer.nvim')

    -- Libs lua
    use({
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
    })

    --- Lsp
    use({
        'neovim/nvim-lspconfig',
        'kabouzeid/nvim-lspinstall',
        'ray-x/lsp_signature.nvim',
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        'onsails/lspkind-nvim',
    })

    -- Completion
    use('hrsh7th/nvim-compe')

    -- Snippets
    use({
        'hrsh7th/vim-vsnip',
        'hrsh7th/vim-vsnip-integ',
        'L3MON4D3/luasnip',
    })

    --- Format/Lint
    use('mhartington/formatter.nvim')

    --- Telescope
    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-project.nvim',
        },
    })

    use('nvim-telescope/telescope-project.nvim')

    --- Treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
        },
        run = ':TSUpdate',
    })

    -- Fzf
    use({
        'junegunn/fzf',
        dir = '~/.fzf',
        run = './install --all',
    })

    use('junegunn/fzf.vim')

    -- Dev div tools
    use({
        'editorconfig/editorconfig-vim',
        'tpope/vim-commentary',
        'junegunn/vim-easy-align',
        'tpope/vim-surround',
        'folke/trouble.nvim',
        'tpope/vim-repeat',
    })

    use({ 'windwp/nvim-autopairs' })

    use({
        'norcalli/nvim-colorizer.lua',
        ft = { 'css', 'scss', 'html', 'javascript', 'lua', 'twig', 'html.twig' },
        config = function()
            require('colorizer').setup()
        end,
    })

    -- Git
    use({
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
    })

    use({
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    })

    -- File explorer
    use('kyazdani42/nvim-tree.lua')

    -- Colors and nice stuff
    use({
        'shaunsingh/nord.nvim',
        'marko-cerovac/material.nvim',
        'kyazdani42/nvim-web-devicons',
    })

    -- Statusline
    use({
        'hoob3rt/lualine.nvim',
        requires = {
            'nvim-web-devicons',
            opt = true,
        },
    })

    -- Div
    use({
        'lukas-reineke/indent-blankline.nvim',
        'farmergreg/vim-lastplace',
    })
end)
