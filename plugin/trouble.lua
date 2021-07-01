-- Trouble

-- mostly default config
require("trouble").setup {
    position    = "bottom",
    height      = 10,
    width       = 50,
    icons       = true,
    -- "lsp_workspace_diagnostics",
    -- "lsp_document_diagnostics",
    -- "quickfix",
    -- "lsp_references",
    -- "loclist"
    mode        = "lsp_document_diagnostics",
    fold_open   = "",
    fold_closed = "",
    action_keys = {
        -- close = {}, -- example of how to remove a mapping
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = {"<cr>", "<tab>"},
        open_split = { "<c-x>" },
        open_vsplit = { "<c-v>" },
        open_tab = { "<c-t>" },
        jump_close = {"o"},
        toggle_mode = "m", -- toggle workspace<->document mode
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = {"zM", "zm"},
        open_folds = {"zR", "zr"},
        toggle_fold = {"zA", "za"},
        previous = "k",
        next = "j"
    },
    indent_lines = true,
    auto_open = false,
    auto_close = true,
    auto_preview = true,
    auto_fold = false,
    signs = {
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}
local map  = vim.api.nvim_set_keymap
local opts = {silent = true, noremap = true}

map("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
map("n", "<leader>xD", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opts)
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", opts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
map("n", "<leader>xR", "<cmd>Trouble lsp_references<cr>", opts)
