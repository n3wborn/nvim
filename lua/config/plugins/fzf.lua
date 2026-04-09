---@diagnostic disable: missing-fields
return {
    src = 'https://github.com/ibhagwan/fzf-lua',
    data = {
        setup = function()
            local fzf = require('fzf-lua')
            local config = fzf.config
            local actions = fzf.actions

            config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
            config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
            config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
            config.defaults.keymap.fzf['ctrl-x'] = 'jump'
            config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
            config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
            config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
            config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'
            config.defaults.file_icons = 'mini'

            fzf.setup('skim')

            config.setup_opts.winopts = { fullscreen = true }
            config.setup_opts.buffers = { formatter = 'path.filename_first' }
            config.setup_opts.lsp = {
                symbols = {
                    child_prefix = false,
                },
                code_actions = {
                    previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
                },
            }

            actions = {
                files = {
                    ['default'] = actions.file_edit_or_qf,
                    ['ctrl-l'] = actions.arg_add,
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-t'] = actions.file_tabedit,
                    ['ctrl-q'] = actions.file_sel_to_qf,
                    ['alt-q'] = actions.file_sel_to_ll,
                },
            }

            -- stylua: ignore start
            vim.keymap.set("n", "<space>F", '<cmd>FzfLua<cr>', { desc = "Fzf main" })
            vim.keymap.set('n', '<leader>ss', fzf.lsp_document_symbols, { desc = 'Goto Symbol' })
            vim.keymap.set('n', '<leader>sS', fzf.lsp_live_workspace_symbols, { desc = 'Goto Symbol (Workspace)' })
            vim.keymap.set('n', '<leader>gd', fzf.lsp_definitions, { desc = 'Goto Definition' })
            vim.keymap.set('n', '<leader>gf', fzf.lsp_finder, { desc = 'LSP Finder' })
            vim.keymap.set('n', '<leader>gi', fzf.lsp_implementations, { desc = 'List Implementation' })
            vim.keymap.set('n', 'gb', function() fzf.buffers({ cwd_only = true }) end, { desc = 'List Buffers (cwd)' })
            vim.keymap.set('n', 'gB', function() fzf.buffers({ cwd_only = false }) end, { desc = 'List Buffers (all)' })
            vim.keymap.set({ 'i', 'x' }, '<C-x><C-f>', function()
                fzf.complete_path({
                    file_icons = true,
                    git_icons = true,
                    color_icons = true,
                    multiprocess = true,
                    winopts = { fullscreen = false },
                })
            end, { desc = 'Complete Path' })
            -- stylua: ignore end
        end,
    },
}
