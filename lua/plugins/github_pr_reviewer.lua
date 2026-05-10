return {
    'otavioschwanck/github-pr-reviewer.nvim',
    opts = {
        branch_prefix = 'reviewing_',
        picker = 'native', -- "native" | "fzf-lua" | "telescope"
        open_files_on_review = true,
        show_comments = true,
        show_icons = true,
        show_inline_diff = true,
        show_floats = true,
        mark_as_viewed_key = '<CR>',
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
    keys = {
        -- stylua: ignore start
        { '<leader>p',  ':PR<cr>',                    { desc = 'PR Review Menu' } },

        { '<leader>pr', ':PRReview<cr>',              { desc = 'Start PR review' } },
        { '<leader>pl', ':PRListReviewRequests<cr>',  { desc = 'List review requests' } },
        { '<leader>pc', ':PRReviewCleanup<cr>',       { desc = 'Cleanup PR review' } },
        { '<leader>pi', ':PRInfo<cr>',                { desc = 'Show PR info' } },
        { '<leader>po', ':PROpen<cr>',                { desc = 'Open PR in browser' } },
        { '<leader>pb', ':PRReviewBuffer<cr>',        { desc = 'Toggle review buffer' } },

        { '<leader>pC', ':PRLineComment<cr>',         { desc = 'Add line comment' } },
        { '<leader>pP', ':PRPendingComment<cr>',      { desc = 'Add pending comment' } },
        { '<leader>pv', ':PRListAllComments<cr>',     { desc = 'List all comments' } },
        { '<leader>pp', ':PRListPendingComments<cr>', { desc = 'List pending comments' } },
        { '<leader>pR', ':PRReply<cr>',               { desc = 'Reply to comment' } },
        { '<leader>pe', ':PREditComment<cr>',         { desc = 'Edit my comment' } },
        { '<leader>pd', ':PRDeleteComment<cr>',       { desc = 'Delete my comment' } },

        { '<leader>pa', ':PRApprove<cr>',             { desc = 'Approve PR' } },
        { '<leader>px', ':PRRequestChanges<cr>',      { desc = 'Request changes' } },
        -- stylua: ignore end
    },
    cmd = {
        'PR',
        'PRReview',
        'PRListReviewRequests',
        'PRReviewCleanup',
        'PRInfo',
        'PROpen',
        'PRReviewBuffer',
        'PRLineComment',
        'PRPendingComment',
        'PRListAllComments',
        'PRListPendingComments',
        'PRReply',
        'PREditComment',
        'PRDeleteComment',
        'PRApprove',
        'PRRequestChanges',
    },
}
