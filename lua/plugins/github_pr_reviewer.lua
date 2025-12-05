return {
    'otavioschwanck/github-pr-reviewer.nvim',
    opts = {
        -- Prefix for review branches (default: "reviewing_")
        branch_prefix = 'reviewing_',

        -- Picker for PR selection: "native", "fzf-lua", or "telescope"
        picker = 'native',

        -- Open the first file automatically
        open_files_on_review = true,

        -- Show PR comments as virtual text in buffers
        show_comments = true,

        -- Show icons/emojis in UI (set to false for a text-only interface)
        show_icons = true,

        -- Show inline diff in buffers (old lines as virtual text above changes)
        show_inline_diff = true,

        -- Show floating windows with PR info, stats, and keymaps
        show_floats = true,

        -- Key to mark file as viewed and go to next file (only works in review mode)
        mark_as_viewed_key = '<CR>',

        -- Key to toggle between unified and split diff view (only works in review mode)
        diff_view_toggle_key = '<C-v>',

        -- Key to toggle floating windows visibility (only works in review mode)
        toggle_floats_key = '<C-r>',

        -- Key to jump to next hunk (only works in review mode)
        next_hunk_key = '<C-j>',

        -- Key to jump to previous hunk (only works in review mode)
        prev_hunk_key = '<C-k>',

        -- Key to go to next modified file (only works in review mode)
        next_file_key = '<C-l>',

        -- Key to go to previous modified file (only works in review mode)
        prev_file_key = '<C-h>',
    },
    cmd = { 'PR' },
    keys = {
        { '<leader>p', '<cmd>PRReviewMenu<cr>', desc = 'PR Review Menu' },
        { '<leader>p', '<cmd>PRSuggestChange<CR>', desc = 'Suggest change', mode = 'v' },
    },
    config = function(_, opts)
        require('github-pr-reviewer').setup(opts)

        -- -- Quick menu access
        -- vim.keymap.set('n', '<leader>p', ':PR<CR>', { desc = 'PR Review Menu' })
        --
        -- -- Review workflow
        -- vim.keymap.set('n', '<leader>pr', ':PRReview<CR>', { desc = 'Start PR review' })
        -- vim.keymap.set('n', '<leader>pl', ':PRListReviewRequests<CR>', { desc = 'List review requests' })
        -- vim.keymap.set('n', '<leader>pc', ':PRReviewCleanup<CR>', { desc = 'Cleanup PR review' })
        -- vim.keymap.set('n', '<leader>pi', ':PRInfo<CR>', { desc = 'Show PR info' })
        -- vim.keymap.set('n', '<leader>po', ':PROpen<CR>', { desc = 'Open PR in browser' })
        -- vim.keymap.set('n', '<leader>pb', ':PRReviewBuffer<CR>', { desc = 'Toggle review buffer' })
        --
        -- -- Comments
        -- vim.keymap.set('n', '<leader>pC', ':PRLineComment<CR>', { desc = 'Add line comment' })
        -- vim.keymap.set('n', '<leader>pP', ':PRPendingComment<CR>', { desc = 'Add pending comment' })
        -- vim.keymap.set('n', '<leader>pv', ':PRListAllComments<CR>', { desc = 'List all comments' })
        -- vim.keymap.set('n', '<leader>pp', ':PRListPendingComments<CR>', { desc = 'List pending comments' })
        -- vim.keymap.set('n', '<leader>pR', ':PRReply<CR>', { desc = 'Reply to comment' })
        -- vim.keymap.set('n', '<leader>pe', ':PREditComment<CR>', { desc = 'Edit my comment' })
        -- vim.keymap.set('n', '<leader>pd', ':PRDeleteComment<CR>', { desc = 'Delete my comment' })
        --
        -- -- Review actions
        -- vim.keymap.set('n', '<leader>pa', ':PRApprove<CR>', { desc = 'Approve PR' })
        -- vim.keymap.set('n', '<leader>px', ':PRRequestChanges<CR>', { desc = 'Request changes' })
    end,
}
