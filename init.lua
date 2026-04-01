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

require('lazy').setup({
    spec = {
        { import = 'plugins' },
        ---@type LazyPluginSpec
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'b0o/SchemaStore.nvim',
            },
            event = { 'BufReadPre', 'BufNewFile' },
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
            event = 'VeryLazy',
        },
        ---@type LazyPluginSpec
        {

            'nvzone/typr',
            dependencies = 'nvzone/volt',
            opts = {},
            cmd = { 'Typr', 'TyprStats' },
        },
        {
            'DrKJeff16/wezterm-types',
            version = false, -- Get the latest version
        },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    install = {
        missing = true,
        colorscheme = { 'catppuccin' },
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

vim.cmd.colorscheme('catppuccin-mocha')

require('config')

local servers = {
    'bashls',
    -- 'intelephense',
    'phpantom',
    'lua_ls',
    -- emmylua_ls',
    'twiggy-language-server',
    'zls',
    'gopls',
    'v_analyzer',
    'tsgo',
    'marksman',
    'jsonls',
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

local signs = require('config.icons').diagnostics

---@type vim.diagnostic.Opts
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

local lsp_group = vim.api.nvim_create_augroup('my.lsp', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_group,
    desc = 'LSP Keymaps',
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local bufnr = ev.buf

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map('n', '<leader>D', vim.diagnostic.open_float, 'Line diagnostics')

        if client:supports_method('textDocument/onTypeFormatting') then
            vim.lsp.on_type_formatting.enable(true, { bufnr = bufnr })
        end

        if client:supports_method('textDocument/documentColor') then
            vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled())
        end

        if client:supports_method('textDocument/inlayHint') and vim.g.lsp_inlay_hints then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if client:supports_method('textDocument/documentHighlight') then
            local group = vim.api.nvim_create_augroup('lsp-highlight-' .. bufnr, { clear = true })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                buffer = bufnr,
                once = true,
                callback = function()
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_del_augroup_by_name('lsp-highlight-' .. bufnr)
                end,
            })
        end
    end,
})
