local util = require('lspconfig.util')

---@type vim.lsp.Config
return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    -- deprecated
    -- root_dir = function(pattern)
    --     local cwd = vim.uv.cwd()
    --     local root = util.root_pattern('composer.json', '.git')(pattern)
    --
    --     -- prefer cwd if root is a descendant
    --     return util.path.is_descendant(cwd, root) and cwd or root
    -- end,
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
