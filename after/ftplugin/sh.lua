---@type vim.lsp.ClientConfig
local config = {
    name = 'bash-language-server',
    cmd = { 'bash-language-server', 'start' },
    settings = {
        bashIde = {
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
        },
    },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'composer.json' }, { upward = true })[1]),
}

vim.lsp.start(config, {
    reuse_client = function(client, conf)
        return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
    end,
})
