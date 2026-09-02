vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        local servers = {
            'bashls',
            'gopls',
            'jsonls',
            -- emmylua_ls',
            'lua_ls',
            'kotlin_lsp',
            'marksman',
            'mpls',
            'oxlint',
            -- TODO: replace static php LSP choice by a function
            -- 'intelephense',
            'php_lsp',
            -- 'phpantom',
            'ts_ls',
            'taplo',
            'ty',
            'twiggy-language-server',
            'v_analyzer',
            'zls',
        }

        for _, server in ipairs(servers) do
            vim.lsp.enable(server)
        end
    end,
})
