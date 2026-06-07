---@type LazyPluginSpec
return {
    'mrcjkb/rustaceanvim',
    lazy = false,
    version = '^9',
    ft = { 'rust' },
    opts = {
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
    },
    config = function(_, opts)
        vim.g.rustaceanvim = vim.tbl_deep_extend('force', {}, opts or {})
    end,
}
