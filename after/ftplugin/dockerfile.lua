---@type vim.lsp.ClientConfig
local config = {
    name = 'docker-langserver',
    cmd = { 'docker-langserver', '--stdio' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'Dockerfile' }, { upward = true })[1]),
    settings = {
        docker = {
            languageserver = {
                formatter = {
                    ignoreMultilineInstructions = true,
                },
            },
        },
    },
}

vim.lsp.start(config, {
    reuse_client = function(client, conf)
        return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
    end,
})
