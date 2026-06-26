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
            '<space>ff',
            function()
                require('fzf-lua').files()
            end,
            desc = 'Find Files',
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
    opts = function()
        local fzf_lua = require('fzf-lua')

        return {
            'skim',
            defaults = { formatter = { 'path.dirname_first', v = 2 } },
            grep = {
                fzf_opts = { ['--history'] = vim.fs.joinpath(vim.fn.stdpath('data'), 'fzf_search_hist') },
            },
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
            -- buffers = {
            --     formatter = 'path.filename_first',
            -- },
            helptags = {
                actions = {
                    -- Open help pages in a vertical split.
                    ['enter'] = require('fzf-lua.actions').help_vert,
                },
            },
            lsp = {
                includeDeclaration = false, -- include current declaration in LSP context
                symbols = {
                    -- lsp_query      = "foo"       -- query passed to the LSP directly
                    -- query          = "bar"       -- query passed to fzf prompt for fuzzy matching
                    locate = false, -- attempt to position cursor at current symbol
                    symbol_style = 1, -- symbols style. false: disable, 1: icon+kind, 2: icon only, 3: kind only
                    fzf_opts = { ['--tiebreak'] = 'begin' },
                },
                code_actions = {
                    previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
                },
                finder = {
                    { 'skim' },
                    providers = {
                        { 'definitions', prefix = fzf_lua.utils.ansi_codes.green('def ') },
                        { 'declarations', prefix = fzf_lua.utils.ansi_codes.magenta('decl') },
                        { 'implementations', prefix = fzf_lua.utils.ansi_codes.green('impl') },
                        { 'typedefs', prefix = fzf_lua.utils.ansi_codes.red('tdef') },
                        { 'references', prefix = fzf_lua.utils.ansi_codes.blue('ref ') },
                        { 'incoming_calls', prefix = fzf_lua.utils.ansi_codes.cyan('in  ') },
                        { 'outgoing_calls', prefix = fzf_lua.utils.ansi_codes.yellow('out ') },
                        { 'type_sub', prefix = fzf_lua.utils.ansi_codes.cyan('sub ') },
                        { 'type_super', prefix = fzf_lua.utils.ansi_codes.yellow('supr') },
                    },
                },
            },
        }
    end,
}
