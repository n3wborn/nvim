vim.g.mapleader = ','
vim.g.maplocalleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require('config.options')

require('lazy').setup({
    spec = {
        { import = 'plugins' },
        { import = 'plugins.extras.lang' },
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'b0o/SchemaStore.nvim',
            },
            event = { 'BufReadPre', 'BufNewFile' },
        },
        {
            'JoosepAlviste/nvim-ts-context-commentstring',
            lazy = true,
            opts = {
                enable_autocmd = false,
            },
        },
        {
            'folke/trouble.nvim',
            cmd = { 'Trouble' },
            opts = {
                modes = {
                    lsp = {
                        win = { position = 'right' },
                    },
                },
            },
            keys = {
                { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
                {
                    '<leader>xX',
                    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                    desc = 'Buffer Diagnostics (Trouble)',
                },
                { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
                { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
                { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
                { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
                {
                    '[q',
                    function()
                        if require('trouble').is_open() then
                            require('trouble').prev({ skip_groups = true, jump = true })
                        else
                            local ok, err = pcall(vim.cmd.cprev)
                            if not ok then
                                vim.notify(err, vim.log.levels.ERROR)
                            end
                        end
                    end,
                    desc = 'Previous Trouble/Quickfix Item',
                },
                {
                    ']q',
                    function()
                        if require('trouble').is_open() then
                            require('trouble').next({ skip_groups = true, jump = true })
                        else
                            local ok, err = pcall(vim.cmd.cnext)
                            if not ok then
                                vim.notify(err, vim.log.levels.ERROR)
                            end
                        end
                    end,
                    desc = 'Next Trouble/Quickfix Item',
                },
            },
            {
                'mbbill/undotree',
                keys = {
                    {
                        '<leader>U',
                        '<cmd>UndotreeToggle<cr>',
                        desc = 'Toggles undotree',
                    },
                },
            },
            {
                'kylechui/nvim-surround',
                version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
                event = 'VeryLazy',
                config = function()
                    require('nvim-surround').setup()
                end,
            },
            {
                'nvzone/typr',
                dependencies = 'nvzone/volt',
                opts = {},
                cmd = { 'Typr', 'TyprStats' },
            },
        },
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

---@type vim.lsp.ClientConfig
vim.lsp.config('*', {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.uv.cwd()
        local root = vim.fs.root(fname, { '.git' })

        on_dir(root and vim.fs.relpath(cwd or {}, root) and cwd)
    end,
    root_markers = { '.git' },
})

local servers = {
    'bashls', -- npm i -g bash-language-server
    'eslint', -- npm i -g vscode-langservers-extracted
    'gopls', -- go install golang.org/x/tools/gopls@latest
    'intelephense', -- npm i -g intelephense
    'jsonls', -- npm i -g vscode-langservers-extracted
    'lua_ls', -- wget https://github.com/LuaLS/lua-language-server/releases/tag/3.16.4
    'marksman', -- wget https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64
    'rumdl', -- cargo binstall rumdl
    'twiggy_language_server', -- npm i -g twiggy-language-server
    'tsgo',
    'v_analyzer', -- https://github.com/vlang/v-analyzer
    'zls', -- prebuilt binary https://zigtools.org/zls/releases/
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

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

require('config.keymaps')
require('config.autocommands')
