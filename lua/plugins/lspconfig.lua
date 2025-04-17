return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'b0o/schemastore.nvim',
    },
    opts = {
        inlay_hints = { enabled = true },
    },
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
        })

        lspconfig.intelephense.setup({
            capabilities = capabilities,
        })
    end,
}
