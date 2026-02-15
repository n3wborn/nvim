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
        {
            '<leader>gd',
            function()
                require('fzf-lua').lsp_definitions()
            end,
            desc = 'Goto Symbol (Workspace)',
        },
        {
            '<leader>gf',
            function()
                require('fzf-lua').lsp_finder()
            end,
            desc = 'LSP finder',
        },
        {
            '<leader>gi',
            function()
                require('fzf-lua').lsp_implementations()
            end,
            desc = 'List Implementation',
        },
        {
            'gb',
            function()
                require('fzf-lua').buffers({ cwd_only = true })
            end,
            desc = 'Search in current working Buffers',
        },
        {
            'gB',
            function()
                require('fzf-lua').buffers({ cwd_only = false })
            end,
            desc = 'Search in every Buffers',
        },
        {
            '<c-x><c-f>',
            function()
                require('fzf-lua').complete_path({
                    file_icons = true,
                    git_icons = true,
                    color_icons = true,
                    multiprocess = true,
                    winopts = { fullscreen = false },
                })
            end,
            desc = 'Complete Path',
            mode = { 'i', 'x' },
        },
    },
    config = function()
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
    end,
}
