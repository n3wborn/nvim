--- @type vim.lsp.Config
return {
    name = 'intelephense',
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 10485760, -- 10Mo
                associations = { '*.php', '*.phtml' },
            },
        },
    },
}
