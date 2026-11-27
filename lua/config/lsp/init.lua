local M = {}

M.capabilities = require('config.lsp.capabilities')
M.keymaps = require('config.lsp.keymaps')

function M.setup()
    require('config.lsp.diagnostics').setup()
    require('config.lsp.servers')
    require('config.lsp.attach')
    -- Toggled with `<leader>uc` (see plugins/snacks.lua).
    vim.lsp.codelens.enable(vim.g.lsp_code_lens)
end

return M
