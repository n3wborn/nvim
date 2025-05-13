---@type vim.lsp.Config
return {
    name = 'intelephense',
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.uv.cwd()
        local root = vim.fs.root(fname, { 'composer.json', '.git' })

        on_dir(root and vim.fs.relpath(cwd, root) and cwd)
    end,
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 10485760, -- 10Mo
            },
        },
    },
}
