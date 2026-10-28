-- https://github.com/PHPantom-dev/phpantom_lsp (`cargo binstall phpantom_lsp`)
---@type vim.lsp.Config
return {
    name = 'phpantom',
    cmd = { 'phpantom_lsp' },
    filetypes = { 'php' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)

        if fname == '' then
            return
        end

        local found = vim.fs.find({ '.phpantom.toml', '.git', 'composer.json' }, {
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
}
