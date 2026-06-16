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
            'tsgo',
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
