-- https://github.com/Hessesian/kmp-lsp
-- cargo binstall kmp-lsp
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
    },
    settings = {},
}
