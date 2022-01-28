vim.cmd('packadd packer.nvim')
local cmd = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local fn = vim.fn

-- install packer if needed
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
end

require('packer').init({
    -- /home/stef/.local/share/nvim/site/pack/packer/start/packer.nvim/packer_compiled.lua
    compile_path = install_path .. '/packer_compiled.lua',
})

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
        'ray-x/lsp_signature.nvim',
        'jose-elias-alvarez/nvim-lsp-ts-utils',
    })

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
        },
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
        'windwp/nvim-ts-autotag',
        ft = { 'typescript', 'typescriptreact' },
    })
    use({
        'JoosepAlviste/nvim-ts-context-commentstring',
        ft = { 'typescript', 'typescriptreact' },
    })

    use({ 'nvim-treesitter/nvim-treesitter-textobjects' })

    -- Fzf
    use({
        'junegunn/fzf',
        dir = '~/.fzf',
        run = './install --all',
    })

    use({ 'junegunn/fzf.vim' })

    -- Dev div tools
    use({
        'editorconfig/editorconfig-vim',
        'b3nj5m1n/kommentary',
        'junegunn/vim-easy-align',
        'tpope/vim-surround',
        'folke/trouble.nvim',
        'RRethy/vim-illuminate',
        'b0o/schemastore.nvim',
        'windwp/nvim-autopairs',
        'simrat39/rust-tools.nvim',
        'norcalli/nvim-colorizer.lua',
    })

    use({
        'kkoomen/vim-doge',
        run = ':call doge#install()',
    })

    -- Git
    use({
        'TimUntersberger/neogit',
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
    })

    -- Colors and nice stuff
    use({
        'marko-cerovac/material.nvim',
        'kyazdani42/nvim-web-devicons',
    })

    -- Statusline
    use({
        'nvim-lualine/lualine.nvim',
        requires = {
            'nvim-web-devicons',
            opt = true,
        },
    })

    use({ 'arkav/lualine-lsp-progress' })

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

    -- to be removed once treesitter support solidity ?
    use({ 'tomlion/vim-solidity' })

    if packer_bootstrap then
        require('packer').sync()
    end
end)
