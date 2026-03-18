vim.g.mapleader = ','
vim.g.maplocalleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then
                vim.cmd.packadd('nvim-treesitter')
            end
            vim.cmd('TSUpdate')
        end
    end,
})

-- :help vim-pack
vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/b0o/SchemaStore.nvim' },
    { src = 'https://github.com/SmiteshP/nvim-navic' },
})

require('schemastore').load()
require('nvim-navic').setup({
    lsp = {
        auto_attach = true,
    },
    highlight = true,
    separator = ' › ',
    depth_limit = 3,
    icons = require('config.icons'),
})

-- declare plugins and load
local gitsigns = require('config.plugins.gitsigns')
local gitconflict = require('config.plugins.gitconflict')
local neogit = require('config.plugins.neogit')
local oil = require('config.plugins.oil')
local textobjects = require('config.plugins.textobjects')
local treesitter = require('config.plugins.treesitter')
local undotree = require('config.plugins.undotree')
local snacks = require('config.plugins.snacks')
local fzf = require('config.plugins.fzf')

vim.pack.add({
    gitsigns,
    gitconflict,
    neogit,
    oil,
    textobjects,
    treesitter,
    undotree,
    snacks,
    fzf,
}, {
    load = function(plug)
        local data = plug.spec.data or {}
        ---@type function|nil setup
        local setup = data.setup

        vim.cmd.packadd(plug.spec.name)

        if setup ~= nil and type(setup) == 'function' then
            vim.schedule(function()
                setup()
            end)
        end
    end,
})

require('config')
