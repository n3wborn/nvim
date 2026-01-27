---@type LazyPluginSpec
return {
    'ibhagwan/fzf-lua',
    dependencies = {
        'nvim-mini/mini.icons',
    },
    cmd = 'FzfLua',
    keys = {
        { '<space>F', ':FzfLua<cr>' },
        {
            '<leader>ss',
            function()
                require('fzf-lua').lsp_document_symbols()
            end,
            desc = 'Goto Symbol',
        },
        {
            '<leader>sS',
            function()
                require('fzf-lua').lsp_live_workspace_symbols()
            end,
            desc = 'Goto Symbol (Workspace)',
        },
    },
    opts = function()
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

        return {
            lsp = {
                symbols = {
                    child_prefix = false,
                },
                code_actions = {
                    previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
                },
            },
            buffers = {
                formatter = 'path.filename_first',
            },
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
            },
        }
    end,
    config = function(_, opts)
        -- require('fzf-lua').setup({ 'defaults', opts })
        -- require('fzf-lua').setup({ 'fzf-native', opts })
        -- require('fzf-lua').setup({ 'fzf-tmux', opts })
        -- require('fzf-lua').setup({ 'fzf-vim', opts })
        -- require('fzf-lua').setup({ 'max-perf', opts })
        -- require('fzf-lua').setup({ 'telescope', opts })
        require('fzf-lua').setup({ 'skim', opts })
    end,
}
