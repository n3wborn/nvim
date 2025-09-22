vim.g.mapleader = ','

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

require('custom.options')

require('lazy').setup({
    spec = {
        { import = 'plugins' },
        {
            'zbirenbaum/copilot.lua',
            cmd = 'Copilot',
            build = ':Copilot auth',
            event = 'BufReadPost',
            enabled = vim.g.copilot_enabled,
            opts = {
                suggestion = {
                    enabled = vim.g.copilot_enabled,
                    auto_trigger = true,
                    hide_during_completion = vim.g.ai_cmp,
                    keymap = {
                        accept = false,
                        next = '<M-j>',
                        prev = '<M-k>',
                    },
                },
                panel = { enabled = false },
                filetypes = {
                    markdown = true,
                    help = true,
                },
            },
        },
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'b0o/SchemaStore.nvim',
            },
            event = { 'BufReadPre', 'BufNewFile' },
        },
        {
            'kylechui/nvim-surround',
            version = '*',
            event = 'VeryLazy',
            config = function()
                require('nvim-surround').setup()
            end,
        },
        {
            {
                'nvim-mini/mini.comment',
                event = 'VeryLazy',
                opts = {
                    options = {
                        custom_commentstring = function()
                            return require('ts_context_commentstring.internal').calculate_commentstring()
                                or vim.bo.commentstring
                        end,
                    },
                },
            },
            {
                'JoosepAlviste/nvim-ts-context-commentstring',
                lazy = true,
                opts = {
                    enable_autocmd = false,
                },
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
        },
        {
            'nvzone/typr',
            dependencies = 'nvzone/volt',
            opts = {},
            cmd = { 'Typr', 'TyprStats' },
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

local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

capabilities.textDocument.onTypeFormatting = { dynamicRegistration = false }

---@type vim.lsp.ClientConfig
vim.lsp.config('*', {
    capabilities = capabilities,
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.uv.cwd()
        local root = vim.fs.root(fname, { '.git' })

        on_dir(root and vim.fs.relpath(cwd or {}, root) and cwd)
    end,
    root_markers = { '.git' },
})

vim.lsp.on_type_formatting.enable()

local servers = {
    -- 'basedpyright', -- https://detachhead.github.io/basedpyright
    'bashls', -- npm i -g bash-language-server
    'cssls', -- npm i -g vscode-langservers-extracted
    'copilot', -- npm i -g @github/copilot-language-server
    -- 'phptools', -- npm i -g devsense-php-ls
    'emmet_language_server', -- npm i -g @olrtg/emmet-language-server
    -- 'emmylua_ls', -- cargo install emmylua_ls
    'eslint', -- npm i -g vscode-langservers-extracted
    'html', -- npm i -g vscode-langservers-extracted
    'intelephense', -- npm i -g intelephense
    'jsonls', -- npm i -g vscode-langservers-extracted
    'lua_ls',
    'oxlint', -- npm i -g oxlint
    'twiggy_language_server', -- npm i -g twiggy-language-server
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

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

    severity_sort = true,
    underline = false,
    update_in_insert = true,
    float = true,
    jump = { on_jump = vim.diagnostic.open_float },
})

require('custom.keymaps')
require('custom.autocommands')
