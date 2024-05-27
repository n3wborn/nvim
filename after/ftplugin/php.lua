local config = {
    name = 'intelephense',
    cmd = { 'intelephense', '--stdio' },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'composer.json' }, { upward = true })[1]),
}

vim.lsp.start(config, {
    reuse_client = function(client, conf)
        return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
    end,
})
