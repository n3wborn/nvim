-- https://github.com/folke/trouble.nvim

require('trouble').setup({
    -- "workspace_diagnostics",
    -- "document_diagnostics",
    -- "quickfix",
    -- "lsp_references",
    -- "loclist"
    mode = 'document_diagnostics',
})

-- mappings
local u = require('utils')

u.map('n', '<leader>xx', '<cmd>Trouble<cr>')
u.map('n', '<leader>xD', '<cmd>Trouble workspace_diagnostics<cr>')
u.map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>')
u.map('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
u.map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
u.map('n', '<leader>xR', '<cmd>Trouble lsp_references<cr>')
