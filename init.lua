vim.g.mapleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('custom')
require('lazy').setup({
    spec = {
        { import = 'plugins' },
        {
            'bloznelis/before.nvim',
            keys = {
                {
                    '<C-j>',
                    function()
                        require('before').jump_to_last_edit()
                    end,
                },
                {
                    '<C-k>',
                    function()
                        require('before').jump_to_next_edit()
                    end,
                },
            },
        },
        {
            'famiu/bufdelete.nvim',
        },
        {
            'hasansujon786/nvim-navbuddy',
            cmd = 'Navbuddy',
            keys = {
                { '<leader>N', '<cmd>Navbuddy<cr>', desc = 'nabuddy' },
            },
            dependencies = {
                'SmiteshP/nvim-navic',
                'MunifTanjim/nui.nvim',
            },
            opts = { lsp = { auto_attach = true } },
        },
        {
            'folke/persistence.nvim',
            event = 'BufReadPre', -- this will only start session saving when an actual file was opened
            opts = {
                dir = vim.fn.stdpath('state') .. '/sessions/', -- directory where session files are saved
                -- minimum number of file buffers that need to be open to save
                -- Set to 0 to always save
                need = 1,
                branch = true, -- use git branch to save session
            },
        },
        {
            'kylechui/nvim-surround',
            version = '*',
            event = 'VeryLazy',
            config = function()
                require('nvim-surround').setup({})
            end,
        },
        {
            'folke/todo-comments.nvim',
            lazy = true,
            config = true,
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
    jump = { severity = vim.log.levels.ERROR },
})

local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('blink.cmp').get_lsp_capabilities({}, false)
)

--- @type vim.lsp.Config
vim.lsp.config('*', {
    capabilities = capabilities,
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.uv.cwd()
        local root = vim.fs.root(fname, { '.git' })

        on_dir(root and vim.fs.relpath(cwd, root) and cwd)
    end,
    root_markers = { '.git' },
})

local servers = {
    'basedpyright',
    'bash_language_server',
    'cssls',
    'emmet_language_server',
    'eslint',
    'html',
    'jsonls',
    'lua_ls',
    'twiggy_language_server',
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

-- intelephense
vim.lsp.config('intelephense', {
    name = 'intelephense',
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 10485760, -- 10Mo
            },
        },
    },
})

vim.lsp.enable('intelephense')
