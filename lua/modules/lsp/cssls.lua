local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach)
    lspconfig.cssls.setup({
        cmd = { 'vscode-css-language-server', '--stdio' },
    })
end

return M
