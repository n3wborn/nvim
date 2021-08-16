local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach)
    lspconfig.jsonls.setup({
        cmd = { 'vscode-json-language-server', '--stdio' },
        filetypes = { 'json' },
        init_options = {
            provideFormatter = true,
        },
        root_dir = root_pattern('.git') or dirname,
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
                end,
            },
        },
    })
end

return M
