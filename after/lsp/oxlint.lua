---  npm i -g oxlint
---@type vim.lsp.Config
return {
    cmd = { 'oxlint', '--lsp' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
    },
    root_markers = {
        'oxlint.config.ts',
        'oxlint.config.mts',
        'oxlint.config.js',
        'oxlint.config.mjs',
        '.oxlintrc.json',
        '.oxlintrc.jsonc',
        'package.json',
        '.git',
    },
}
