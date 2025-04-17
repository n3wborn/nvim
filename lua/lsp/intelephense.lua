return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    -- root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.uv.cwd()
        local util = require('lspconfig.util')
        local root = util.root_pattern('composer.json', '.git')(fname)

        on_dir(util.path.is_descendant(cwd, root) and cwd or root)
    end,
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        intelephense = {
            files = {
                maxSize = 10485760, -- 10Mo
            },
        },
    },
}
