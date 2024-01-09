return {
    {
        'mrcjkb/rustaceanvim',
        version = '^3',
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
    },

    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                rust_analyzer = {},
                taplo = {
                    keys = {
                        {
                            'K',
                            function()
                                if vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
                                    require('crates').show_popup()
                                else
                                    vim.lsp.buf.hover()
                                end
                            end,
                            desc = 'Show Crate Documentation',
                        },
                    },
                },
            },
            setup = {
                rust_analyzer = function()
                    return true
                end,
            },
        },
    },
}
