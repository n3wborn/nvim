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
            desc = 'Goto Definition',
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
            desc = 'Buffers (cwd)',
        },
        {
            'gB',
            function()
                require('fzf-lua').buffers({ cwd_only = false })
            end,
            desc = 'Buffers (all)',
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
            mode = { 'i', 'x' },
            desc = 'Complete Path',
        },
    },
    ---@type fzf-lua.Config
    opts = {
        'skim',
        winopts = {
            fullscreen = true,
        },
        keymap = {
            fzf = {
                ['ctrl-q'] = 'select-all+accept',
                ['ctrl-u'] = 'half-page-up',
                ['ctrl-d'] = 'half-page-down',
                ['ctrl-x'] = 'jump',
                ['ctrl-f'] = 'preview-page-down',
                ['ctrl-b'] = 'preview-page-up',
                ['ctrl-s down'] = 'preview-page-down',
                ['ctrl-up'] = 'preview-page-up',
            },
            builtin = {
                ['<c-f>'] = 'preview-page-down',
                ['<c-b>'] = 'preview-page-up',
            },
        },
        file_icons = 'mini',
        buffers = {
            formatter = 'path.filename_first',
        },
        lsp = {
            symbols = {
                child_prefix = false,
            },
            code_actions = {
                previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
            },
        },
    },
}
