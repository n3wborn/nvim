-- https://github.com/folke/trouble.nvim

require("trouble").setup {
    -- "lsp_workspace_diagnostics",
    -- "lsp_document_diagnostics",
    -- "quickfix",
    -- "lsp_references",
    -- "loclist"
    mode        = "lsp_document_diagnostics",
}

-- mappings
local map  = vim.api.nvim_set_keymap
local opts = {silent = true, noremap = true}

map("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
map("n", "<leader>xD", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opts)
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", opts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
map("n", "<leader>xR", "<cmd>Trouble lsp_references<cr>", opts)
