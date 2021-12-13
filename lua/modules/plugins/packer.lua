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
    use({
        'mhartington/formatter.nvim',
        config = [[ require('modules.plugins.formatter') ]],
    })

    --- Telescope
    use({
        'nvim-telescope/telescope.nvim',
        config = [[ require('modules.plugins.telescope') ]],
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
        run = ':TSUpdate',
        config = [[require('modules.plugins.treesitter')]],
    })

    use({
        'windwp/nvim-ts-autotag',
        ft = { 'typescript', 'typescriptreact' },
    })
    use({
        'JoosepAlviste/nvim-ts-context-commentstring',
        ft = { 'typescript', 'typescriptreact' },
    })

    use('nvim-treesitter/nvim-treesitter-textobjects')

    -- Fzf
    use({
        'junegunn/fzf',
        dir = '~/.fzf',
        run = './install --all',
    })

    use('junegunn/fzf.vim')

    -- File explorer
    use({
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = [[ require('modules.lua.nvimtree') ]],
    })

    -- Dev div tools
    use({
        'editorconfig/editorconfig-vim',
        'b3nj5m1n/kommentary',
        'junegunn/vim-easy-align',
        'tpope/vim-surround',
        'folke/trouble.nvim',
        'RRethy/vim-illuminate',
    })

    use({ 'b0o/schemastore.nvim' })

    use({ 'windwp/nvim-autopairs' })

    use({
        'norcalli/nvim-colorizer.lua',
        config = [[ require('modules.plugins.colorizer') ]],
    })

    use({
        'kkoomen/vim-doge',
        run = ':call doge#install()',
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
        config = [[ require('modules.plugins.gitsigns') ]],
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

    -- Div
    use({ 'tpope/vim-repeat' })

    use({
        'lukas-reineke/indent-blankline.nvim',
        config = [[ require('modules.plugins.blankline') ]],
    })

    use({
        'kwkarlwang/bufjump.nvim',
        config = [[ require('bufjump').setup() ]],
    })

    -- to be removed once treesitter support solidity ?
    use({ 'tomlion/vim-solidity' })

    if packer_bootstrap then
        require('packer').sync()
    end
end)
