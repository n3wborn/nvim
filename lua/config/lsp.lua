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

local servers = {
    'intelephense',
    'lua_ls',
    -- emmylua_ls',
    'bashls',
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
