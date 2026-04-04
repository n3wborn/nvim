-- https://github.com/Hessesian/kotlin-lsp
-- cargo binstall kotlin-lsp
---@type vim.lsp.Config
return {
    name = 'kotlin_lsp',
    cmd = { 'kotlin-lsp' },
    filetypes = { 'kotlin', 'java' },
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
