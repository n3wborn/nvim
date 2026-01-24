---@type vim.lsp.Config
vim.lsp.config('*', {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.uv.cwd()
        local root = vim.fs.root(fname, { '.git' })

        on_dir(root and vim.fs.relpath(cwd or {}, root) and cwd)
    end,
    root_markers = { '.git' },
})

---@type vim.lsp.Config
vim.lsp.config('intelephense', {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 20 * 1024 * 1024, -- 20Mo
                associations = { '*.php', '*.phtml' },
            },
        },
    },
    root_markers = { '.git', 'composer.json' },
})
vim.lsp.enable('intelephense')

local servers = {
    'bashls', -- npm i -g bash-language-server
    'eslint', -- npm i -g vscode-langservers-extracted
    'gopls', -- go install golang.org/x/tools/gopls@latest
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
