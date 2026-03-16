vim.g.mapleader = ','
vim.g.maplocalleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('config.options')

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
local mini_pairs = require('config.plugins.mini_pairs')
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
    mini_pairs,
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
