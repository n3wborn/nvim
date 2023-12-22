local settings = {
    Lua = {
        codeLens = { enable = true },
        diagnostics = {
            globals = { 'vim' },
        },
        telemetry = { enable = false },
        runtime = {
            version = 'LuaJIT',
        },
        workspace = {
            library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                [vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy'] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
        },
        format = {
            enable = false,
            defaultConfig = {
                indent_size = '2',
                indent_style = 'space',
                quote_style = 'single',
                max_line_length = '80',
                trailing_table_separator = 'smart',
                -- NOTE: some options break some formatting properties? :(
                -- in fact a lot of things are buggy (removing `quote_style`
                -- property allows trailing table separators to be more
                -- comprehensive) but... good enough :)
                -- break_all_list_when_line_exceed = true, --breaks things sadly
                call_arg_parentheses = 'remove_table_only',
                -- align_call_args = true, -- breaks things sadly
            },
        },
        completion = {
            showWord = 'Disable',
            callSnippet = 'Replace',
            keywordSnippet = 'Disable',
        },
    },
}

local M = {
    setup = function(on_attach, capabilities)
        require('neodev').setup({
            override = function(root_dir, library)
                if root_dir:match('dotfiles') then
                    library.enabled = true
                    library.plugins = true
                end
            end,
        })

        require('lspconfig').lua_ls.setup({
            on_attach = on_attach,
            settings = settings,
            flags = {
                debounce_text_changes = 150,
            },
            capabilities = capabilities,
        })
    end,
}

return M
