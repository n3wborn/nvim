---@type vim.lsp.Config
return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local buf_dir = vim.fs.dirname(fname)
        local markers = { '.git', 'composer.json' }

        local found = vim.fs.find(markers, {
            upward = true,
            path = buf_dir,
            limit = math.huge,
        })

        -- Pick the topmost match
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
                maxSize = 300 * 1024 * 1024, -- 300Mo
                exclude = {
                    '**/.git/**',
                    '**/.svn/**',
                    '**/.hg/**',
                    '**/CVS/**',
                    '**/.DS_Store/**',
                    '**/node_modules/**',
                    '**/bower_components/**',
                    '**/vendor/**/{Tests,tests}/**',
                    '**/.history/**',
                    '**/vendor/**/vendor/**',
                    '**/var/log/**',
                    '**/var/storage/**',
                    '**/var/tmp/**',
                    '**/var/cache/*/Container*/**',
                    '**/var/cache/*/Symfony/**',
                    '**/var/cache/*/pools/**',
                    '**/var/cache/*/profiler/**',
                    '**/dumps/**',
                    '**/.pnpm-store/**',
                },
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
                    -- Classes Propel générées (bin/console surface:propel:build --om),
                    -- gitignorées, jamais éditées à la main : lib/model/<schema>/om|map/
                    -- et src/**/Model/<schema>/om|map/. Les diagnostics dessus ne sont
                    -- que du bruit (elles ne sont pas indexées comme fichiers "vendor").
                    ['**/lib/model/**/om/**'] = { '*' },
                    ['**/lib/model/**/map/**'] = { '*' },
                    ['**/src/**/Model/**/om/**'] = { '*' },
                    ['**/src/**/Model/**/map/**'] = { '*' },
                },
                implementationErrors = true,
                noMixedTypeCheck = true,
                relaxedTypeCheck = true,
                run = 'onSave',
            },
            maxMemory = 4096,
            inlayHint = {
                parameterNames = true,
                parameterTypes = true,
                returnTypes = true,
            },
        },
    },
}
