local settings = {
    Lua = {
        diagnostics = {
            globals = { 'vim' },
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
