---@type vim.lsp.Config
return {
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 20 * 1024 * 1024, -- 20Mo
                associations = { '*.php', '*.phtml' },
            },
        },
    },
}
