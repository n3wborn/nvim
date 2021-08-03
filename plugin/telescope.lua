-- https://github.com/nvim-telescope/telescope.nvim

require('telescope').setup({
    defaults = {
        sorting_strategy = 'ascending',
        mappings = {
            i = {
                ['<ESC>'] = require('telescope.actions').close,
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
})

-- Mappings
local function setup_mappings()
    local map = require('utils').map
    local b_require = "<cmd>lua require('telescope.builtin')."

    local kmaps = {
        -- General builtins
        sp = 'live_grep()',
        sd = 'grep_string()',
        f = 'find_files()',
        b = 'buffers()',
        o = 'oldfiles()',
        E = 'file_browser()',
        t = 'treesitter()',
        -- Git builtins
        gc = 'git_commits()',
        gb = 'git_branches()',
        gs = 'git_status()',
        gp = 'git_bcommits()',
        gS = 'git_stash()',
        -- lsp builtins
        ls = 'lsp_document_symbols()',
        lD = 'lsp_document_diagnostics()',
        lr = 'lsp_references()',
        li = 'lsp_implementations()',
        ld = 'lsp_definitions()',
        la = 'lsp_code_actions()',
    }

    for key, builtin in pairs(kmaps) do
        map('n', '<leader>' .. key, b_require .. builtin .. '<cr>')
    end

    -- Call Telescope with sugar
    map('n', '<leader>T', [[:Telescope<cr>]])

    -- Telescope project extension
    map('n', '<C-p>', [[:lua require'telescope'.extensions.project.project{}<CR>]])
end

setup_mappings()
