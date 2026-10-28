-- https://intelephense.com/docs (`npm i intelephense -g`)
---@type vim.lsp.Config
return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)

        if fname == '' then
            return
        end

        local found = vim.fs.find({ '.git', 'composer.json' }, {
            upward = true,
            path = vim.fs.dirname(fname),
            limit = math.huge,
        })

        local root

        -- use topmost root (ex: project_root/plugins/submodule will use project_root)
        for _, match in ipairs(found) do
            local dir = vim.fs.dirname(match)

            if not root or #dir < #root then
                root = dir
            end
        end

        if root then
            on_dir(root)
        end
    end,
    workspace_required = true,
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    ---@type lspconfig.settings.intelephense
    settings = {
        intelephense = {
            files = {
                -- Taille maximale d'un fichier individuel (10 Mio).
                maxSize = 10 * 1024 * 1024,

                exclude = {
                    '**/.git/**',
                    '**/.svn/**',
                    '**/.hg/**',
                    '**/CVS/**',
                    '**/.DS_Store',
                    '**/node_modules/**',
                    '**/bower_components/**',
                    '**/vendor/**/{Tests,tests}/**',
                    '**/.history/**',
                    '**/vendor/**/vendor/**',
                    '**/var/log/**',
                    '**/var/storage/**',
                    '**/var/tmp/**',
                    '**/var/cache/**',
                    '**/dumps/**',
                    '**/.pnpm-store/**',
                },
            },
            telemetry = {
                enabled = false,
            },
            codeLens = {
                implementations = { enable = true },
                overrides = { enable = true },
                parent = { enable = true },
                references = { enable = true },
                usages = { enable = true },
            },
            completion = {
                maxItems = 150,
                parameterCase = 'camel',
                propertyCase = 'camel',
            },
            diagnostics = {
                deprecated = true,
                exclude = {
                    -- disable for vendor
                    ['**/vendor/**'] = { '*' },
                    -- disable for Propel ORM classes
                    ['**/lib/model/**/om/**'] = { '*' },
                    ['**/lib/model/**/map/**'] = { '*' },
                    ['**/src/**/Model/**/om/**'] = { '*' },
                    ['**/src/**/Model/**/map/**'] = { '*' },
                },
                implementationErrors = true,
                -- avoid false positives
                relaxedTypeCheck = true,
                run = 'onSave',
            },
            maxMemory = 4096,
        },
    },
}
