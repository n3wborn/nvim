---@type vim.lsp.Config
return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local buf_dir = vim.fs.dirname(fname)

        -- Walk upward and collect ALL matches, not just the first one
        local markers = { '.git', 'composer.json' }
        local found = vim.fs.find(markers, {
            upward = true,
            path = buf_dir,
            -- Don't stop at the first match: find them all up to /
            limit = math.huge,
        })

        -- Pick the topmost (closest to /) match
        local root = nil
        for _, match in ipairs(found) do
            local dir = vim.fs.dirname(match)
            if root == nil or #dir < #root then
                root = dir
            end
        end

        on_dir(root or vim.uv.cwd())
    end,
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
