---@type LazyPluginSpec
return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    keys = {
        { '<space>F', ':FzfLua<cr>' },
    },
    opts = function()
        local actions = require('fzf-lua.actions')
        return {
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
