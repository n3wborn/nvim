---@type vim.lsp.Config
return {
    name = 'phpantom',
    cmd = { 'phpantom_lsp' },
    filetypes = { 'php' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local buf_dir = vim.fs.dirname(fname)

        -- Walk upward and collect ALL matches, not just the first one
        -- local markers = { '.phpantom.toml', '.git', 'composer.json' }
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
    -- root_markers = { '.phpantom.toml', '.git', 'composer.json' },
}
