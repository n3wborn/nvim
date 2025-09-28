return {
    ---@type LazyPluginSpec
    {
        'sindrets/diffview.nvim',
        cmd = {
            'DiffviewOpen',
            'DiffviewClose',
            'DiffviewRefresh',
            'DiffviewFileHistory',
            'DiffviewFocusFiles',
            'DiffviewToggleFiles',
        },
        keys = {
            {
                '<leader><leader>v',
                function()
                    if next(require('diffview.lib').views) == nil then
                        vim.cmd('DiffviewOpen')
                    else
                        vim.cmd('DiffviewClose')
                    end
                end,
                desc = 'toogle diffview',
            },
        },
        config = function()
            require('diffview')
        end,
    },
    {
        'NeogitOrg/neogit',
        cmd = { 'Neogit' },
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'sindrets/diffview.nvim', -- optional - Diff integration
            'echasnovski/mini.pick', -- optional
        },
        opts = {

            graph_style = 'kitty',
            -- Show relative date by default. When set, use `strftime` to display dates
            commit_date_format = nil,
            process_spinner = true,
            git_services = {
                ['github.com'] = {
                    pull_request = 'https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1',
                    commit = 'https://github.com/${owner}/${repository}/commit/${oid}',
                    tree = 'https://${host}/${owner}/${repository}/tree/${branch_name}',
                },
                ['gitlab.com'] = {
                    pull_request = 'https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}',
                    commit = 'https://gitlab.com/${owner}/${repository}/-/commit/${oid}',
                    tree = 'https://gitlab.com/${owner}/${repository}/-/tree/${branch_name}?ref_type=heads',
                },
            },
            -- Persist the values of switches/options within and across sessions
            remember_settings = true,
            -- Scope persisted settings on a per-project basis
            use_per_project_settings = true,
            -- Table of settings to never persist. Uses format "Filetype--cli-value"
            ignored_settings = {},
            -- Configure highlight group features
            -- Change the default way of opening neogit
            kind = 'tab',
            -- Floating window style
            floating = {
                relative = 'editor',
                width = 0.8,
                height = 0.7,
                style = 'minimal',
                border = 'rounded',
            },
            status = {
                show_head_commit_hash = true,
                recent_commit_count = 10,
                HEAD_padding = 10,
                HEAD_folded = false,
                mode_padding = 3,
                mode_text = {
                    M = 'modified',
                    N = 'new file',
                    A = 'added',
                    D = 'deleted',
                    C = 'copied',
                    U = 'updated',
                    R = 'renamed',
                    DD = 'unmerged',
                    AU = 'unmerged',
                    UD = 'unmerged',
                    UA = 'unmerged',
                    DU = 'unmerged',
                    AA = 'unmerged',
                    UU = 'unmerged',
                    ['?'] = '',
                },
            },
            commit_editor = {
                kind = 'tab',
                show_staged_diff = true,
                -- Accepted values:
                -- "split" to show the staged diff below the commit editor
                -- "vsplit" to show it to the right
                -- "split_above" Like :top split
                -- "vsplit_left" like :vsplit, but open to the left
                -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
                staged_diff_split_kind = 'split',
                spell_check = true,
            },
            commit_select_view = {
                kind = 'tab',
            },
            commit_view = {
                kind = 'vsplit',
                verify_commit = vim.fn.executable('gpg') == 1, -- Can be set to true or false, otherwise we try to find the binary
            },
            log_view = {
                kind = 'tab',
            },
            rebase_editor = {
                kind = 'auto',
            },
            reflog_view = {
                kind = 'tab',
            },
            merge_editor = {
                kind = 'auto',
            },
            preview_buffer = {
                kind = 'floating_console',
            },
            popup = {
                kind = 'split',
            },
            stash = {
                kind = 'tab',
            },
            refs_view = {
                kind = 'tab',
            },
            signs = {
                -- { CLOSED, OPENED }
                hunk = { '', '' },
                item = { '>', 'v' },
                section = { '>', 'v' },
            },
            -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
            integrations = {
                diffview = true,
                mini_pick = true,
                -- snacks = true,
            },
            sections = {
                -- Reverting/Cherry Picking
                sequencer = {
                    folded = false,
                    hidden = false,
                },
                untracked = {
                    folded = false,
                    hidden = false,
                },
                unstaged = {
                    folded = false,
                    hidden = false,
                },
                staged = {
                    folded = false,
                    hidden = false,
                },
                stashes = {
                    folded = true,
                    hidden = false,
                },
                unpulled_upstream = {
                    folded = true,
                    hidden = false,
                },
                unmerged_upstream = {
                    folded = false,
                    hidden = false,
                },
                unpulled_pushRemote = {
                    folded = true,
                    hidden = false,
                },
                unmerged_pushRemote = {
                    folded = false,
                    hidden = false,
                },
                recent = {
                    folded = true,
                    hidden = false,
                },
                rebase = {
                    folded = true,
                    hidden = false,
                },
            },
            mappings = {
                commit_editor = {
                    ['q'] = 'Close',
                    ['<c-c><c-c>'] = 'Submit',
                    ['<c-c><c-k>'] = 'Abort',
                    ['<m-p>'] = 'PrevMessage',
                    ['<m-n>'] = 'NextMessage',
                    ['<m-r>'] = 'ResetMessage',
                },
                commit_editor_I = {
                    ['<c-c><c-c>'] = 'Submit',
                    ['<c-c><c-k>'] = 'Abort',
                },
                rebase_editor = {
                    ['p'] = 'Pick',
                    ['r'] = 'Reword',
                    ['e'] = 'Edit',
                    ['s'] = 'Squash',
                    ['f'] = 'Fixup',
                    ['x'] = 'Execute',
                    ['d'] = 'Drop',
                    ['b'] = 'Break',
                    ['q'] = 'Close',
                    ['<cr>'] = 'OpenCommit',
                    ['gk'] = 'MoveUp',
                    ['gj'] = 'MoveDown',
                    ['<c-c><c-c>'] = 'Submit',
                    ['<c-c><c-k>'] = 'Abort',
                    ['[c'] = 'OpenOrScrollUp',
                    [']c'] = 'OpenOrScrollDown',
                },
                rebase_editor_I = {
                    ['<c-c><c-c>'] = 'Submit',
                    ['<c-c><c-k>'] = 'Abort',
                },
                finder = {
                    ['<cr>'] = 'Select',
                    ['<c-c>'] = 'Close',
                    ['<esc>'] = 'Close',
                    ['<c-n>'] = 'Next',
                    ['<c-p>'] = 'Previous',
                    ['<down>'] = 'Next',
                    ['<up>'] = 'Previous',
                    ['<tab>'] = 'InsertCompletion',
                    ['<c-y>'] = 'CopySelection',
                    ['<space>'] = 'MultiselectToggleNext',
                    ['<s-space>'] = 'MultiselectTogglePrevious',
                    ['<c-j>'] = 'NOP',
                    ['<ScrollWheelDown>'] = 'ScrollWheelDown',
                    ['<ScrollWheelUp>'] = 'ScrollWheelUp',
                    ['<ScrollWheelLeft>'] = 'NOP',
                    ['<ScrollWheelRight>'] = 'NOP',
                    ['<LeftMouse>'] = 'MouseClick',
                    ['<2-LeftMouse>'] = 'NOP',
                },
                -- Setting any of these to `false` will disable the mapping.
                popup = {
                    ['?'] = 'HelpPopup',
                    ['A'] = 'CherryPickPopup',
                    ['d'] = 'DiffPopup',
                    ['M'] = 'RemotePopup',
                    ['P'] = 'PushPopup',
                    ['X'] = 'ResetPopup',
                    ['Z'] = 'StashPopup',
                    ['i'] = 'IgnorePopup',
                    ['t'] = 'TagPopup',
                    ['b'] = 'BranchPopup',
                    ['B'] = 'BisectPopup',
                    ['w'] = 'WorktreePopup',
                    ['c'] = 'CommitPopup',
                    ['f'] = 'FetchPopup',
                    ['l'] = 'LogPopup',
                    ['m'] = 'MergePopup',
                    ['p'] = 'PullPopup',
                    ['r'] = 'RebasePopup',
                    ['v'] = 'RevertPopup',
                },
                status = {
                    ['j'] = 'MoveDown',
                    ['k'] = 'MoveUp',
                    ['o'] = 'OpenTree',
                    ['q'] = 'Close',
                    ['I'] = 'InitRepo',
                    ['1'] = 'Depth1',
                    ['2'] = 'Depth2',
                    ['3'] = 'Depth3',
                    ['4'] = 'Depth4',
                    ['Q'] = 'Command',
                    ['<tab>'] = 'Toggle',
                    ['za'] = 'Toggle',
                    ['zo'] = 'OpenFold',
                    ['x'] = 'Discard',
                    ['s'] = 'Stage',
                    ['S'] = 'StageUnstaged',
                    ['<c-s>'] = 'StageAll',
                    ['u'] = 'Unstage',
                    ['K'] = 'Untrack',
                    ['U'] = 'UnstageStaged',
                    ['y'] = 'ShowRefs',
                    ['$'] = 'CommandHistory',
                    ['Y'] = 'YankSelected',
                    ['<c-r>'] = 'RefreshBuffer',
                    ['<cr>'] = 'GoToFile',
                    ['<s-cr>'] = 'PeekFile',
                    ['<c-v>'] = 'VSplitOpen',
                    ['<c-x>'] = 'SplitOpen',
                    ['<c-t>'] = 'TabOpen',
                    ['{'] = 'GoToPreviousHunkHeader',
                    ['}'] = 'GoToNextHunkHeader',
                    ['[c'] = 'OpenOrScrollUp',
                    [']c'] = 'OpenOrScrollDown',
                    ['<c-k>'] = 'PeekUp',
                    ['<c-j>'] = 'PeekDown',
                    ['<c-n>'] = 'NextSection',
                    ['<c-p>'] = 'PreviousSection',
                },
            },
        },
    },
    ---@type LazyPluginSpec
    {
        'akinsho/git-conflict.nvim',
        version = '*',
        config = true,
        lazy = false, -- contrary to it's doc, we have to set lazy to false  to load the plugin
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
        opts = {
            signs = {
                add = { text = '│ ' },
                change = { text = '│ ' },
                delete = { text = '│ ' },
                topdelete = { text = '│ ' },
                changedelete = { text = '│ ' },
            },
            signs_staged = {
                add = { text = '│ ' },
                change = { text = '│ ' },
                delete = { text = '│ ' },
                topdelete = { text = '│ ' },
                changedelete = { text = '│ ' },
            },
            current_line_blame = true,
            preview_config = {
                style = 'minimal',
            },
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align
                delay = 999,
                ignore_whitespace = false,
                virt_text_priority = 99,
            },
            watch_gitdir = { enabled = true, follow_files = true },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
                end

                map('n', '<leader>hn', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gs.nav_hunk('next', { preview = true })
                    end
                end, 'Next Hunk')
                map('n', '<leader>hN', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gs.nav_hunk('prev', { preview = true })
                    end
                end, 'Prev Hunk')
                map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', '󰊢 (Un)Stage Hunk')
                map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', '󰊢 Reset Hunk')
                map('n', '<leader>hS', gs.stage_buffer, '󰊢 Stage Buffer')
                map('n', '<leader>hu', gs.undo_stage_hunk, '󰊢 Undo Stage Hunk')
                map('n', '<leader>hR', gs.reset_buffer, '󰊢 Reset Buffer')
                map('n', '<leader>hp', gs.preview_hunk_inline, '󰊢 Preview Hunk Inline')
                map('n', '<leader>hb', function()
                    gs.blame_line({ full = true })
                end, '󰊢 Blame Line')
                map('n', '<leader>hB', function()
                    gs.blame()
                end, '󰊢 Blame Buffer')
                map('n', '<leader>tb', function()
                    gs.toogle_current_line_blame()
                end, '󰊢 Toogle Current B')
                map('n', '<leader>hd', '<cmd>GitsignsDiffToggle<cr>', '󰊢 Diff This')
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', '󰊢 GitSigns Select Hunk')
            end,
        },
    },
}
