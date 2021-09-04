-- https://github.com/folke/trouble.nvim

require('trouble').setup({
    -- "lsp_workspace_diagnostics",
    -- "lsp_document_diagnostics",
    -- "quickfix",
    -- "lsp_references",
    -- "loclist"
    mode = 'lsp_document_diagnostics',
})

-- mappings
local u = require('utils')

u.map('n', '<leader>xx', '<cmd>Trouble<cr>')
u.map('n', '<leader>xD', '<cmd>Trouble lsp_workspace_diagnostics<cr>')
u.map('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>')
u.map('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
u.map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
u.map('n', '<leader>xR', '<cmd>Trouble lsp_references<cr>')
