vim.g.mapleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('custom')
require('lazy').setup({
    spec = {
        { import = 'plugins' },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    install = {
        missing = true,
        colorscheme = { 'catpuccin' },
    },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
    ui = { border = 'rounded' },
})

require('custom.keymaps')
require('custom.autocommands')

local signs = require('custom.icons').diagnostics

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
        },
    },
    virtual_text = false,
    severity_sort = true,
    underline = false,
    update_in_insert = true,
    jump = { float = true },
})

vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    root_markers = { '.git' },
    reuse_client = function(client, conf)
        return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
    end,
})

local servers = { 'intelephense', 'lua_ls', 'twiggy_language_server', 'emmet_language_server', 'basedpyright' }

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end
