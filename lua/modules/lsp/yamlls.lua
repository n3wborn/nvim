local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach)
    lspconfig.yamlls.setup({
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { 'yaml' },
        root_dir = root_pattern('.git') or dirname,
    })
end

return M
