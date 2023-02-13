local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local ensure_packer = function()
    local fn = vim.fn

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end

    return false
end

local packer_bootstrap = ensure_packer()

require('packer').init({ compile_path = install_path .. '/packer_compiled.lua' })

return require('packer').startup(function(use)
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
        'jose-elias-alvarez/typescript.nvim',
    })

    use({ 'folke/neodev.nvim' })

    use({
        'jose-elias-alvarez/null-ls.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
        },
    })

    -- Completion
    use({
        'hrsh7th/nvim-cmp',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'lukas-reineke/cmp-rg',
    })

    use({ 'onsails/lspkind.nvim' })

    -- Snippets
    use({
        'L3MON4D3/luasnip',
        requires = {
            'rafamadriz/friendly-snippets',
        },
    })

    --- Format/Lint
    use({ 'mhartington/formatter.nvim' })

    --- Telescope
    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
    })

    use({
        'danielfalk/smart-open.nvim',
        requires = { 'tami5/sqlite.lua' },
    })

    use({
        'nvim-telescope/telescope-project.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
        },
    })

    --- Treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    })

    use({
        'nvim-treesitter/nvim-treesitter-textobjects',
        'windwp/nvim-ts-autotag',
    })

    -- Fzf
    use({
        'junegunn/fzf',
        dir = '~/.fzf',
        run = './install --all',
    })

    use({ 'junegunn/fzf.vim' })

    -- Dev div tools
    use({
        'b3nj5m1n/kommentary',
        'kylechui/nvim-surround',
        'onsails/diaglist.nvim',
        'b0o/schemastore.nvim',
        'windwp/nvim-autopairs',
        'simrat39/rust-tools.nvim',
        'norcalli/nvim-colorizer.lua',
    })

    use({
        'tzachar/local-highlight.nvim',
        config = [[require('local-highlight').setup()]],
    })

    use({
        'kevinhwang91/nvim-bqf',
        config = [[require('bqf').setup()]],
    })

    -- Git
    use({ 'kdheepak/lazygit.nvim' })

    use({
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
    })

    -- Colors and nice stuff
    use({ 'catppuccin/nvim' })

    use({
        'marko-cerovac/material.nvim',
        'kyazdani42/nvim-web-devicons',
    })

    use({
        'folke/noice.nvim',
        requires = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    })

    -- window sizing
    use({
        'anuvyklack/windows.nvim',
        requires = {
            'anuvyklack/middleclass',
            'anuvyklack/animation.nvim',
        },
    })

    -- Statusline
    use({
        'nvim-lualine/lualine.nvim',
        requires = {
            'nvim-web-devicons',
            opt = true,
        },
    })

    use({
        'SmiteshP/nvim-navic',
        config = [[require("nvim-navic").setup({highlight = true})]],
        requires = 'neovim/nvim-lspconfig',
    })

    use({
        'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
    })

    -- Notify
    use({ 'rcarriga/nvim-notify' })

    -- Explorer
    use({
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    })

    -- Div
    use({
        'lukas-reineke/indent-blankline.nvim',
        'tpope/vim-repeat',
    })

    if packer_bootstrap then
        require('packer').sync()
    end
end)
