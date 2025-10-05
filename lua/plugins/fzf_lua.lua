---@type LazyPluginSpec
return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    keys = {
        { '<space>F', ':FzfLua<cr>' },
        {
            '<leader>o',
            function()
                require('fzf-lua').oldfiles({ formatter = 'path.filename_first' })
            end,
            desc = 'Old files opened',
        },
        {
            '<leader>gc',
            function()
                require('fzf-lua').git_commits()
            end,
            desc = 'Git Commits',
        },
        {
            '<leader>gp',
            function()
                require('fzf-lua').git_bcommits()
            end,
            desc = 'Git commit log (buffer)',
        },
        {
            '<leader>gS',
            function()
                require('fzf-lua').git_stash()
            end,
            desc = 'Git Stashes',
        },
        {
            '<leader>gf',
            function()
                require('fzf-lua').git_bcommits()
            end,
            desc = 'Git Status',
        },
        {
            '<leader>lr',
            function()
                require('fzf-lua').lsp_references() --- nvim default grr
            end,
            desc = 'List symbol References',
        },
        {
            '<leader>li',
            function()
                require('fzf-lua').lsp_implementations() --- nvim default gri
            end,
            desc = 'List Implementations',
        },
        {
            '<leader>lO',
            function()
                require('fzf-lua').lsp_outcoming_calls()
            end,
            desc = 'List Outcoming calls',
        },
        {
            '<leader>lI',
            function()
                require('fzf-lua').lsp_incoming_calls()
            end,
            desc = 'List Incoming calls',
        },
        {
            '<leader>m',
            function()
                require('fzf-lua').marks()
            end,
            desc = 'List Marks',
        },
        {
            '<leader>sH',
            function()
                require('fzf-lua').grep_project({
                    filter = [[rg "Helper.php"]],
                    regex_filter = true,
                    winopts = { title = 'Search in [H]elpers' },
                })
            end,
        },
        {
            '<leader>sA',
            function()
                require('fzf-lua').grep_project({
                    filter = [[rg "actions.class.php"]],
                    regex_filter = true,
                    winopts = { title = 'Search in [A]ctions' },
                })
            end,
        },
        {
            '<leader>sG',
            function()
                require('fzf-lua').grep_project({
                    filter = [[rg "generator.yml"]],
                    regex_filter = true,
                    winopts = { title = 'Search in [G]enerators' },
                })
            end,
        },
        {
            '<leader>sh',
            function()
                require('fzf-lua').grep_cword({
                    filter = [[rg "Helper.php"]],
                    regex_filter = true,
                    winopts = { title = 'Search Current Word in [H]elpers' },
                })
            end,
        },
        {
            '<leader>sa',
            function()
                require('fzf-lua').grep_cword({
                    filter = [[rg "actions.class.php"]],
                    regex_filter = true,
                    winopts = { title = 'Search Current Word in [A]ctions' },
                })
            end,
        },
        {
            '<leader>sg',
            function()
                require('fzf-lua').grep_cword({
                    filter = [[rg "generator.yml"]],
                    regex_filter = true,
                    winopts = { title = 'Search Current Word in [G]enerators' },
                })
            end,
        },
    },
    opts = function()
        local actions = require('fzf-lua.actions')
        return {
            -- https://github.com/ibhagwan/nvim-lua/blob/dc846e06d3a9e1df99840d2fc833dca1d0b6e4e1/lua/plugins/fzf-lua/setup.lua#L67
            -- fzf_opts = {
            --     ['--no-info'] = '',
            --     ['--info'] = 'hidden',
            --     ['--padding'] = '13%,5%,13%,5%',
            --     ['--header'] = ' ',
            --     ['--no-scrollbar'] = '',
            -- },
            -- files = {
            --     previewer = 'bat',
            --     git_icons = true,
            --     preview_opts = 'hidden',
            --     find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
            --     rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
            --     fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
            -- },
            buffers = {
                formatter = 'path.filename_first',
            },
            git = {
                bcommits = {
                    cmd = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen%><(12)%cr%><|(12)%Creset %s' <file>",
                    preview = "git show --stat --color --format='%C(cyan)%an%C(reset)%C(bold yellow)%d%C(reset): %s' {1} -- <file>",
                    actions = {
                        ['ctrl-d'] = function(...)
                            require('fzf-lua').actions.git_buf_vsplit(...)
                            vim.cmd('windo diffthis')
                            local switch = vim.api.nvim_replace_termcodes('<C-w>h', true, false, true)
                            vim.api.nvim_feedkeys(switch, 't', false)
                        end,
                    },
                    preview_opts = 'nohidden',
                },
                git_status = {
                    actions = {
                        ['ctrl-s'] = function(...)
                            require('fzf-lua').actions.git_buf_split(...)
                        end,
                    },
                },
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
