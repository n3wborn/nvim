---@type LazyPluginSpec
return {
    'mrcjkb/rustaceanvim',
    lazy = false, -- This plugin is already lazy
    version = '^6', -- Recommended
    ft = { 'rust' },
    opts = {
        server = {
            settings = {
                -- rust-analyzer language server configuration
                ['rust-analyzer'] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    -- Add clippy lints for Rust.
                    checkOnSave = {
                        allFeatures = true,
                        command = 'clippy',
                        extraArgs = { '--no-deps' },
                    },
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
