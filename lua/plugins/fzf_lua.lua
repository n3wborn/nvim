return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    keys = {
        { '<space>F', '<cmd>FzfLua<cr>', desc = 'open FzfLua' },
        {
            '<leader>ff',
            function()
                require('fzf-lua').files()
            end,
            desc = 'Find File',
        },
        {
            '<leader>fF',
            function()
                require('fzf-lua').files()
            end,
            desc = 'Find File',
        },
        {
            '<leader>sp',
            function()
                require('fzf-lua').grep_project()
            end,
            desc = 'Search Project',
        },
        {
            '<leader>sd',
            function()
                require('fzf-lua').grep_cword()
            end,
            desc = 'Grep Current Word',
        },
        {
            '<leader>o',
            function()
                require('fzf-lua').oldfiles()
            end,
            desc = 'Old files opened',
        },
        {
            '<leader>b',
            function()
                require('fzf-lua').buffers()
            end,
            desc = 'Find Buffers',
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
            desc = 'Git Previous commits',
        },
        {
            '<leader>gb',
            function()
                require('fzf-lua').git_branches()
            end,
            desc = 'Git Branch',
        },
        {
            '<leader>gS',
            function()
                require('fzf-lua').git_stash()
            end,
            desc = 'Git Stashes',
        },
        {
            '<leader>gs',
            function()
                require('fzf-lua').git_status()
            end,
            desc = 'Git Status',
        },
        {
            '<leader>lr',
            function()
                require('fzf-lua').lsp_references()
            end,
            desc = 'List symbol References',
        },
        {
            '<leader>li',
            function()
                require('fzf-lua').lsp_implementations()
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
    },
    opts = function()
        local actions = require('fzf-lua.actions')
        return {
            -- https://github.com/ibhagwan/nvim-lua/blob/dc846e06d3a9e1df99840d2fc833dca1d0b6e4e1/lua/plugins/fzf-lua/setup.lua#L67
            winopts = {
                height = 0.25,
                width = 0.4,
                row = 0.5,
                -- hl = { normal = 'Pmenu' },
                -- border = 'none',
            },
            fzf_opts = {
                ['--no-info'] = '',
                ['--info'] = 'hidden',
                ['--padding'] = '13%,5%,13%,5%',
                ['--header'] = ' ',
                ['--no-scrollbar'] = '',
            },
            files = {
                previewer = 'bat',
                git_icons = true,
                preview_opts = 'hidden',
                find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
                rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
                fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
            },
            buffers = {
                formatter = 'path.filename_first',
                preview_opts = 'hidden',
                fzf_opts = { ['--delimiter'] = ' ', ['--with-nth'] = '-1..' },
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
                    winopts = {
                        preview = {
                            layout = 'vertical',
                            vertical = 'right:50%',
                            wrap = 'wrap',
                        },
                        row = 1,
                        width = vim.api.nvim_win_get_width(0),
                        height = 0.3,
                    },
                },
                branches = {
                    cmd = 'git branch --all --color',
                    winopts = {
                        preview = {
                            layout = 'vertical',
                            vertical = 'right:50%',
                            wrap = 'wrap',
                        },
                        row = 1,
                        width = vim.api.nvim_win_get_width(0),
                        height = 0.3,
                    },
                },
            },
            autocmds = {
                winopts = {
                    width = 0.8,
                    height = 0.7,
                },
            },
            grep = {
                rg_glob = false,
                glob_flag = '--iglob', -- for case sensitive globs use '--glob'
                glob_separator = '%s%-%-', -- query separator pattern (lua): ' --'
                grep_opts = '--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e',
                rg_opts = '--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
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
        -- calling `setup` is optional for customization
        require('fzf-lua').setup({ 'max-perf', opts })
    end,
}
