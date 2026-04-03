---@type vim.lsp.Config
return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_markers = { '.git', 'composer.json' },
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    ---@type lspconfig.settings.intelephense
    settings = {
        intelephense = {
            files = {
                maxSize = 20 * 1024 * 1024, -- 20Mo
            },
            telemetry = {
                enabled = false,
            },
            codeLens = {
                implementations = { enabled = true },
                overrides = { enabled = true },
                parent = { enabled = true },
                references = { enabled = true },
                usages = { enabled = true },
            },
            completion = {
                maxItems = 150,
                parameterCase = 'camel',
                propertyCase = 'camel',
            },
            diagnostics = {
                deprecated = true,
                exclude = {
                    ['**/vendor/**'] = { '*' }, -- override this by setting `**/vendor/** = {}`
                },
                implementationErrors = true,
                noMixedTypeCheck = true,
                relaxedTypeCheck = true,
                run = 'onSave',
            },
            maxMemory = 1024,
            inlayHint = {
                parameterNames = true,
                parameterTypes = true,
                returnTypes = true,
            },
        },
    },
}
