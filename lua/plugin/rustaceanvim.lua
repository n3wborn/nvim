local add = require('vim-pack').add

-- Must be set before the plugin is loaded (rustaceanvim is not meant to be lazy-loaded).
vim.g.rustaceanvim = {
    server = {
        settings = {
            ---@type lspconfig.settings.rust_analyzer
            ['rust-analyzer'] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                },
                checkOnSave = true,
                procMacro = {
                    enable = true,
                    ignored = {
                        ['async-trait'] = { 'async_trait' },
                        ['napi-derive'] = { 'napi' },
                        ['async-recursion'] = { 'async_recursion' },
                    },
                },
            },
        },
    },
}

add({
    { src = 'mrcjkb/rustaceanvim', version = vim.version.range('^9'), setup = false },
})
