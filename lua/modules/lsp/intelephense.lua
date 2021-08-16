local lspconfig = require('lspconfig')

local M = {}

M.setup = function(on_attach)
    lspconfig.intelephense.setup({
        init_options = {
            globalStoragePath = vim.env.XDG_DATA_HOME .. '/intelephense',
        },
        cmd = { 'intelephense', '--stdio' },
        filetypes = { 'php' },
        root_dir = root_pattern('composer.json', '.git'),
    })
end

return M
