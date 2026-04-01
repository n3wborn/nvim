---@type vim.lsp.Config
return {
    name = 'phpantom',
    cmd = { 'phpantom_lsp' },
    filetypes = { 'php' },
    -- deprecated (from lspconfig intelephense)
    -- root_dir = function(pattern)
    --     local cwd = vim.uv.cwd()
    --     local root = util.root_pattern('composer.json', '.git')(pattern)
    --
    --     -- prefer cwd if root is a descendant
    --     return util.path.is_descendant(cwd, root) and cwd or root
    -- end,
    -- phpantom_lsp doc set it like this: `root_markers = { 'composer.json', '.git' }`
    root_markers = { '.git', 'composer.json' },
}
