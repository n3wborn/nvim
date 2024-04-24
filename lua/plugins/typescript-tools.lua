return {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
        require('typescript-tools').setup({
            settings = {
                jsx_close_tag = { enable = true },
                tsserver_plugins = {
                    '@styled/typescript-styled-plugin',
                },
                --- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = 'all',
                    includeCompletionsForModuleExports = true,
                },
                -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3418
                tsserver_format_options = {
                    allowIncompleteCompletions = false,
                    allowRenameOfImportPath = true,
                },
            },
        })
    end,
}
