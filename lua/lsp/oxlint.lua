--- https://oxc.rs
return {
    name = { 'oxc' },
    cmd = { 'oxc_language_server' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    workspace_required = true,
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.uv.cwd()
        local root = vim.fs.root(fname, { '.oxlintrc.json' })

        on_dir(root and vim.fs.relpath(cwd, root) and cwd)
    end,
}
