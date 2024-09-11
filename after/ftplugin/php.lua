---@type vim.lsp.ClientConfig
local config = {
    name = 'intelephense',
    cmd = { 'intelephense', '--stdio' },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'composer.json' }, { upward = true })[1]),
    settings = {
        files = {
            maxSize = 10000000, -- 10M
        },
        -- See https://github.com/bmewburn/intelephense-docs
    },
}

vim.lsp.start(config, {
    reuse_client = function(client, conf)
        return (client.name == conf.name and (client.config.root_dir == conf.root_dir))
    end,
    bufnr = vim.api.nvim_get_current_buf(),
})
