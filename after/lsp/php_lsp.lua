-- https://github.com/jorgsowa/php-lsp (`cargo binstall php-lsp`)
---@type vim.lsp.Config
return {
    cmd = { 'php-lsp' },
    filetypes = { 'php' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local buf_dir = vim.fs.dirname(fname)

        -- Monorepo multi-plugins (surface) : walk upward and collect ALL
        -- matches, not just the first one, comme pour intelephense/phpantom.
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
    workspace_required = true,
    init_options = {
        excludePaths = {
            '.git/*',
            'vendor/*',
            'node_modules/*',
            'bower_components/*',
            'var/log/*',
            'var/storage/*',
            'var/tmp/*',
            'var/cache/*/Container*',
            'var/cache/*/Symfony*',
            'var/cache/*/pools/*',
            'var/cache/*/profiler/*',
            'dumps/*',
            '.pnpm-store/*',
        },
    },
}
