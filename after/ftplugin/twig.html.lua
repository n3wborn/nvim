---@type vim.lsp.ClientConfig
local config = {
    name = 'twiggy_language_server',
    cmd = { 'twiggy-language-server', '--stdio' },
    root_dir = function()
        local util = require('lspconfig.util')
        util.root_dir('composer.json', '.git')
    end,
}

vim.lsp.start(config, {
    reuse_client = function(client, conf)
        return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
    end,
    bufnr = vim.api.nvim_get_current_buf(),
})
