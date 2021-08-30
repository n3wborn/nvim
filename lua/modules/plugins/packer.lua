local cmd = vim.api.nvim_command
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local fn = vim.fn

-- install packer if needed
if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    cmd('packadd packer.nvim')
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
        'ray-x/lsp_signature.nvim',
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        'onsails/lspkind-nvim',
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
        'hrsh7th/nvim-compe',
        config = function()
            require('modules.plugins.compe')
        end,
        requires = {
            'L3MON4D3/luasnip',
        },
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
        config = function()
            require('modules.plugins.formatter')
        end,
    })

    --- Telescope
    use({
        'nvim-telescope/telescope.nvim',
        config = function()
            require('modules.plugins.telescope')
        end,
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
        config = function()
            require('modules.plugins.treesitter')
        end,
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
        'b3nj5m1n/kommentary',
        'junegunn/vim-easy-align',
        'tpope/vim-surround',
        'folke/trouble.nvim',
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
        config = [[require('modules.plugins.gitsigns')]],
    })

    -- File explorer
    use({
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('modules.plugins.nvimtree')
        end,
    })

    -- Colors and nice stuff
    use({
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

    -- Lua
    use({
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup()
        end,
    })

    -- Div
    use({ 'tpope/vim-repeat' })

    use({
        'rafcamlet/nvim-luapad',
        config = function()
            require('luapad').setup({
                count_limit = 150000,
                error_indicator = true,
                eval_on_move = true,
                error_highlight = 'WarningMsg',
            })
        end,
    })
    use({
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('modules.plugins.blankline')
        end,
    })
end)
