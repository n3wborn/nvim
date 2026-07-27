---@diagnostic disable: missing-fields
---@type LazyPluginSpec
return {
    'mistweaverco/kulala.nvim',
    -- Load before session save/restore so VimLeavePre and SessionLoadPost hooks are registered.
    event = { 'SessionLoadPost', 'VimLeavePre' },
    ---@type KulalaDefaultConfig
    keys = {
        {
            '<leader>rR',
            function()
                require('kulala').run()
            end,
            mode = { 'n', 'v' },
        },
        {
            '<leader>rA',
            function()
                require('kulala').run_all()
            end,
            mode = { 'n', 'v' },
        },
    },
    opts = {
        kulala_core = {
            timeout = 60000,
            -- Restore request history and UI after sourcing a vim session.
            -- Requires `set sessionoptions+=globals` in your Neovim config.
            session = {
                restore = true,
            },
            treesitter = {
                enable = true,
            },
            -- dev, test, prod, can be anything
            -- `"b"` = per-buffer env (default), `"g"` = global
            environment_scope = 'b',
            -- enable reading vscode rest client environment variables
            vscode_rest_client_environmentvars = false,

            -- Response body pretty-printing
            response_format = {
                indent = 2,
                expand_tabs = true,
                sort_keys = false,
            },
            ui = {
                -- display mode: possible values: "split", "float"
                display_mode = 'split',
                -- split direction: possible values: "above", "right", "below", "left", fun(): "above"|"right"|"below"|"left"
                split_direction = 'right',
                -- window options to override win_config: width/height/split/vertical.., buffer/window options
                win_opts = { bo = {}, wo = {} }, ---@type kulala.ui.win_config
                -- default view: "body" or "headers" or "headers_body" or "verbose" or fun(response: Response)
                default_view = 'body', ---@type "body"|"headers"|"headers_body"|"verbose"|fun(response: Response)
            },
            lsp = {
                enable = true,
                ---filetypes to attach Kulala LSP to
                ---@type string[]
                filetypes = {
                    'http',
                    'rest',
                },

                ---@type boolean|table
                keymaps = false, -- disabled by default, as Kulala relies on default Neovim LSP keymaps
                on_attach = nil, -- function called when Kulala LSP attaches to the buffer
            },
            global_keymaps = false,
        },
    },
}
