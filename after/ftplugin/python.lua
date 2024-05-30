---@type vim.lsp.ClientConfig
local config = {
    name = 'basedpyright',
    cmd = { 'basedpyright-langserver', '--stdio' },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'openFilesOnly',
                useLibraryCodeForTypes = true,
            },
        },
    },
}
---@type vim.lsp.start.Opts
local opts = {
    reuse_client = function(client, conf)
        return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
    end,
}

vim.lsp.start(config, opts)
