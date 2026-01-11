vim.g.mapleader = ','
vim.g.maplocalleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('config.options')

-- :help vim-pack
vim.pack.add({
    { src = 'https://github.com/b0o/SchemaStore.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/rafamadriz/friendly-snippets' },
    -- { src = 'https://github.com/moyiz/blink-emoji.nvim' },
})

-- return {
--     src = '',
--     data = {
--         setup = function()
--         end,
--     },
-- }
--
-- git
vim.pack.add({ 'https://github.com/kdheepak/lazygit.nvim' })
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>')
-- ui
vim.pack.add({ { src = 'https://github.com/nvim-lualine/lualine.nvim.git', name = 'lualine' } })
require('lualine').setup()

vim.pack.add({ 'https://github.com/HiPhish/rainbow-delimiters.nvim' })

vim.pack.add({ { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } })
require('catppuccin').setup({
    flavour = 'mocha',
    transparent_background = true,
    -- lsp_styles = {
    --     virtual_text = {
    --         errors = { 'italic' },
    --         hints = { 'italic' },
    --         warnings = { 'italic' },
    --         information = { 'italic' },
    --         ok = { 'italic' },
    --     },
    --     underlines = {
    --         errors = { 'undercurl' },
    --         hints = { 'undercurl' },
    --         warnings = { 'undercurl' },
    --         information = { 'undercurl' },
    --     },
    --     inlay_hints = {
    --         background = true,
    --     },
    -- },
    styles = {
        functions = { 'italic' },
    },
    -- auto_integrations = true,
})
vim.cmd('colorscheme catppuccin')

vim.pack.add({ 'https://github.com/stevearc/quicker.nvim' })
require('quicker').setup()

-- declare plugins and load
local blink = require('config.plugins.blink')
local conform = require('config.plugins.conform')
local gitsigns = require('config.plugins.gitsigns')
local oil = require('config.plugins.oil')
local textobjects = require('config.plugins.textobjects')
local treesitter = require('config.plugins.treesitter')
local undotree = require('config.plugins.undotree')

vim.pack.add({
    blink,
    conform,
    gitsigns,
    oil,
    textobjects,
    treesitter,
    undotree,
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

-- filetype
vim.filetype.add({
    extension = { rasi = 'rasi', rofi = 'rasi', wofi = 'rasi', mdc = 'markdown' },
    filename = {
        ['.env'] = 'dotenv',
        ['vifmrc'] = 'vim',
        log = 'log',
        conf = 'conf',
    },
    pattern = {
        ['.*twig'] = 'twig.html',
        ['.*/waybar/config'] = 'jsonc',
        ['.*/mako/config'] = 'dosini',
        ['.*/kitty/*.conf'] = 'bash',
        ['.*/hypr/.*%.conf'] = 'hyprlang',
        ['%.env%.[%w_.-]+'] = 'dotenv',
    },
})
