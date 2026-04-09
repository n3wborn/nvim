require('config.options')
require('config.keymaps')

require('schemastore').load()

-- :help vim-pack
vim.pack.add({
    { src = 'https://github.com/ibhagwan/fzf-lua' },
    { src = 'https://github.com/OXY2DEV/foldtext.nvim' },
    -- { src = 'https://github.com/SmiteshP/nvim-navic' },
    { src = 'https://github.com/b0o/SchemaStore.nvim' },
    { src = 'https://github.com/dmtrKovalenko/fff.nvim' },
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/sindrets/diffview.nvim' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/kdheepak/lazygit.nvim' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://github.com/NeogitOrg/neogit' },
    {
        src = 'https://github.com/nvim-mini/mini.pairs',
        version = 'main',
    },
    {
        src = 'https://github.com/nvim-mini/mini.icons',
        version = 'main',
    },
    { src = 'https://github.com/catppuccin/nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/arborist-ts/arborist.nvim' },
    { src = 'https://github.com/folke/lazydev.nvim' },
    { src = 'https://github.com/garymjr/nvim-snippets' },
    {
        src = 'https://github.com/saghen/blink.cmp',
        version = vim.version.range('^1'),
    },

    -- { src = 'https://github.com/akinsho/git-conflict.nvim' },
    -- { src = 'https://github.com/f-person/git-blame.nvim' },
    -- { src = 'https://github.com/mfussenegger/nvim-lint' },
})

-- declare plugins and load
local function load_plugins()
    local plugin_dir = vim.fn.stdpath('config') .. '/lua/config/plugins'
    for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
        if file:match('%.lua$') then
            local module = file:gsub('%.lua$', '')
            require('config.plugins.' .. module)
        end
    end
end
load_plugins()

require('config.lsp')
require('config.autocommands')
