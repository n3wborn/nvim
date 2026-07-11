local M = {}

M.capabilities = require('config.lsp.capabilities')
M.keymaps = require('config.lsp.keymaps')

function M.setup()
    require('config.lsp.diagnostics').setup()
    require('config.lsp.servers')
    require('config.lsp.attach')
end

return M
