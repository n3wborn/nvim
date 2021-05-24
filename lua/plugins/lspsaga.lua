-- Lsp-saga

local map  = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local saga = require 'lspsaga'

saga.init_lsp_saga {
    code_action_keys = {
        quit = '<ESC>',
        exec = '<CR>'
    },
    code_action_prompt = {
      enable = true,
      sign = false,
      sign_priority = 20,
      virtual_text = true,
    },
    definition_preview_icon = '  ',
    -- "single" "double" "round" "plus"
    border_style = "single",
    rename_prompt_prefix = '➤'
}

-- Mappings
--
--
-- Find Definition and References
map('n', '<leader>F', [[<cmd>lua require('lspsaga.provider').lsp_finder()<cr>]],  opts)

-- Actions
map('n', '<M-Enter>', [[<cmd>lua require('lspsaga.codeaction').code_action()<cr>]],  opts)
map('v', '<M-Enter>', [[<cmd>lua require('lspsaga.codeaction').range_code_action()<cr>]],  opts)

-- Hover Doc
map('n', 'K', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>]],  opts)

-- Scroll in previews
map('n', '<C-f>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>]],  opts)
map('n', '<C-b>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>]],  opts)

-- show signature help
map('n', '<leader>S', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>]],  opts)

-- rename
-- map('n', '<leader>R', [[<cmd>lua require('lspsaga.rename').rename()<cr>]],  opts)

-- preview definition
map('n', '<leader>P', [[<cmd>lua require('lspsaga.provider').preview_definition()<cr>]],  opts)

-- show diagnostic
map('n', '<leader>D', [[<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<cr>]],  opts)
-- map('n', '<leader>d', [[<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<cr>]],  opts)

-- jump diagnostic
map('n', ']d', [[<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<cr>]],  opts)
map('n', '[d', [[<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<cr>]],  opts)

