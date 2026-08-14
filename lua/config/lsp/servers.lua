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
            -- 'intelephense',
            'phpantom',
            -- `npm install -g typescript typescript-language-server`
            -- ts_go is no longer needed since typescript v7.0
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
