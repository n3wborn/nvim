--- @type vim.lsp.Config
return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_markers = { '.git', 'composer.json' },
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
