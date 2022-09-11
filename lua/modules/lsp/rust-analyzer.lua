local srv_settings = {
    ['rust-analyzer'] = {
        updates = { channel = 'stable' },
        notifications = { cargoTomlNotFound = false },
        assist = {
            importGroup = true,
            importMergeBehaviour = 'full',
            importPrefix = 'by_crate',
        },
        callInfo = {
            full = true,
        },
        cargo = {
            allFeatures = true,
            autoreload = true,
            loadOutDirsFromCheck = true,
        },
        checkOnSave = {
            command = 'clippy',
            allFeatures = true,
            extraArgs = '--tests',
        },
        completion = {
            addCallArgumentSnippets = true,
            addCallParenthesis = true,
            postfix = {
                enable = true,
            },
            autoimport = {
                enable = true,
            },
        },
        diagnostics = {
            enable = true,
            enableExperimental = true,
        },
        hoverActions = {
            enable = true,
            debug = true,
            gotoTypeDef = true,
            implementations = true,
            run = true,
            linksInHover = true,
        },
        inlayHints = {
            chainingHints = true,
            parameterHints = true,
            typeHints = true,
        },
        lens = {
            enable = true,
            debug = true,
            implementations = true,
            run = true,
            methodReferences = true,
            references = true,
        },
        notifications = {
            cargoTomlNotFound = true,
        },
        procMacro = {
            enable = true,
        },
    },
}

local M = {
    setup = function(on_attach, capabilities)
        local rust_opts = {
            tools = {
                autoSetHints = true,
                runnables = {
                    use_telescope = true,
                },
                inlay_hints = {
                    show_parameter_hints = false,
                    parameter_hints_prefix = '',
                    other_hints_prefix = '',
                },
                hover_actions = {
                    border = 'single',
                },
            },
            -- lsp
            server = {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = srv_settings,
            },
        }
        require('rust-tools').setup(rust_opts)
    end,
}

return M
