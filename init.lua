vim.g.mapleader = ','
vim.g.maplocalleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }

require('config.options')

-- plugins

-- :help vim-pack
vim.pack.add({ 'https://github.com/b0o/SchemaStore.nvim' })
vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

-- treesitter
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })
require('nvim-treesitter').setup()

-- formatters
vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
require('conform').setup({
    exclude_path_patterns = {
        '/node_modules/',
        '/vendor/',
    },
    formatters_by_ft = {
        go = { 'gofmt' },
        --- @todo: find a way to deal with work projects related config
        javascript = { 'oxfmt', 'eslint_d', 'prettier_d', 'prettier' },
        -- json = { 'jq' },
        lua = { 'stylua' },
        php = { 'php_cs_fixer' },
        rust = { 'rustfmt' },
        sh = { 'shfmt', 'shellcheck' },
        sql = { 'sql_formatter' },
        typescript = { 'eslint_d', 'eslint' },
        typescriptreact = { 'eslint_d', 'eslint' },
        twig = { 'twig-cs-fixer' },
        v = { 'v' },
        ['*'] = { 'trim_whitespace', 'squeeze_blanks', 'trim_newlines' },
    },
    format_on_save = { async = false, timeout_ms = 2000, lsp_fallback = false },
    formatters = {
        php_cs_fixer = {
            env = { PHP_CS_FIXER_IGNORE_ENV = 1 },
            args = function(_, ctx)
                local args = { 'fix', '$FILENAME', '--quiet', '--no-interaction', '--using-cache=no' }
                local found = nil
                local core_dir = os.getenv('CORE_DIR')
                local root_dir = nil

                if core_dir then
                    root_dir = vim.fs.find(core_dir, { type = 'directory', upward = true, path = ctx.dirname })[1]
                    if root_dir then
                        found = vim.fs.find('.php-cs-fixer.php.dist', { path = root_dir, type = 'file' })[1]
                        vim.api.nvim_echo({ { 'Found corePlugin at:\n' }, { root_dir } }, true, {})
                    end
                end

                if not found then
                    found = vim.fs.find('.php-cs-fixer.php.dist', { upward = true, path = ctx.dirname })[1]
                    if found then
                        vim.api.nvim_echo({ { 'Using fallback php-cs-fixer config:\n' }, { found } }, true, {})
                    end
                end

                if found then
                    vim.list_extend(args, { '--config=' .. found })
                else
                    vim.list_extend(args, { '--rules=@PSR12,@Symfony' })
                end

                return args
            end,
        },
    },
})

-- explorer
vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })
require('oil').setup({
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
    lsp_file_methods = {
        autosave_changes = true,
    },
    columns = { 'icon' },
    keymaps = {
        ['<C-h>'] = false,
        ['<M-h>'] = 'actions.select_split',
    },
    view_options = {
        show_hidden = true,
    },
})

local oil = require('oil')
vim.keymap.set('n', '-', oil.open)

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
