--- https://github.com/Hessesian/kmp-lsp/blob/main/docs/editors.md#neovim-nvim-lspconfig
--- cargo install kmp-lsp
---@type vim.lsp.Config
return {
    cmd = { 'kmp-lsp' },
    filetypes = { 'kotlin', 'java', 'swift' },
    root_markers = {
        'settings.gradle',
        'settings.gradle.kts',
        'build.xml',
        'pom.xml',
        'build.gradle',
        'build.gradle.kts',
        'pom.xml',
        'Package.swift',
        '.git',
    },
    settings = {},
}
