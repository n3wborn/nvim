-- https://github.com/jorgsowa/php-lsp (`cargo binstall php-lsp`)
---@type vim.lsp.Config
return {
    cmd = { 'php-lsp' },
    filetypes = { 'php' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)

        if fname == '' then
            return
        end

        local buf_dir = vim.fs.dirname(fname)
        local markers = { '.git', 'composer.json' }

        local found = vim.fs.find(markers, {
            upward = true,
            path = buf_dir,
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
        excludePaths = {
            'node_modules',
            'bower_components',
            'var/log',
            'var/storage',
            'var/tmp',
            'var/cache',
            'dumps',
        },
    },
}
