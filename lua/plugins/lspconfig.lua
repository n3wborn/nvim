---@type LazyPluginSpec
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'b0o/SchemaStore.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
}
