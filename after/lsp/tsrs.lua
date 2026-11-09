-- https://github.com/oxc-project/tsrs/blob/main/docs/LSP.md#editor-setup
-- npm install -g tsrs
---@type vim.lsp.Config
return {
    cmd = { 'tsrs', '--lsp', '-stdio' }, -- or the absolute path to target/debug/tsrs
    filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
}
