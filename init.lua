vim.g.mapleader = ','
vim.g.maplocalleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('config.options')

-- :help vim-pack
vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
})
-- return {
--     src = '',
--     data = {
--         setup = function()
--         end,
--     },
-- }

-- declare plugins and load
local lazygit = require('config.plugins.lazygit')
local plenary = require('config.plugins.plenary')
local schemastore = require('config.plugins.schemastore')
local conform = require('config.plugins.conform')
local diffview = require('config.plugins.diffview')
local foldtext = require('config.plugins.foldtext')
local gitsigns = require('config.plugins.gitsigns')
local gitconflict = require('config.plugins.gitconflict')
local lualine = require('config.plugins.lualine')
local mini_pairs = require('config.plugins.mini_pairs')
local neogit = require('config.plugins.neogit')
local oil = require('config.plugins.oil')
local rainbow = require('config.plugins.rainbow')
local textobjects = require('config.plugins.textobjects')
local treesitter = require('config.plugins.treesitter')
local undotree = require('config.plugins.undotree')
local snacks = require('config.plugins.snacks')
-- local kulala = require('config.plugins.kulala')
local fzf = require('config.plugins.fzf')

vim.pack.add({
    lazygit,
    plenary,
    schemastore,
    conform,
    diffview,
    foldtext,
    gitsigns,
    gitconflict,
    lualine,
    mini_pairs,
    neogit,
    oil,
    rainbow,
    textobjects,
    treesitter,
    undotree,
    snacks,
    fzf,
}, {
    load = function(plug)
        local data = plug.spec.data or {}
        local setup = data.setup

        vim.cmd.packadd(plug.spec.name)

        if setup ~= nil and type(setup) == 'function' then
            setup()
        end
    end,
})

-- LSP
local servers = {
    'eslint', -- npm i -g vscode-langservers-extracted
    'gopls', -- go install golang.org/x/tools/gopls@latest
    'intelephense', -- npm i -g intelephense
    'jsonls', -- npm i -g vscode-langservers-extracted
    'lua_ls',
    'marksman',
    'oxlint', -- npm i -g oxlint
    'twiggy_language_server', -- npm i -g twiggy-language-server
    'v_analyzer', -- https://github.com/vlang/v-analyzer
    'zls', -- prebuilt binary https://zigtools.org/zls/releases/
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

-- diagnostics
local signs = require('config.icons').diagnostics

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
        },
    },

    severity_sort = true,
    underline = false,
    update_in_insert = true,
    float = true,
    jump = { on_jump = vim.diagnostic.open_float },
})

-- keymaps / autocommands
require('config.keymaps')
require('config.autocommands')
