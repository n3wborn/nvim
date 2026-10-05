local add_on_event = require('vim-pack').add_on_event

-- Only provides the lsp/ configs (servers are enabled in lua/config/lsp).
add_on_event({ 'BufReadPre', 'BufNewFile' }, {
    { src = 'b0o/SchemaStore.nvim', setup = false },
    { src = 'neovim/nvim-lspconfig', setup = false },
})
