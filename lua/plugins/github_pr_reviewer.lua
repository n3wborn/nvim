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
    keys = function()
        local pr = require('github-pr-reviewer')

        -- stylua: ignore start
        return {
            { "<leader>p",  function() pr.menu() end,                  { desc = "PR Review Menu" } },

            { "<leader>pr", function() pr.review() end,                { desc = "Start PR review" } },
            { "<leader>pl", function() pr.list_review_requests() end,  { desc = "List review requests" } },
            { "<leader>pc", function() pr.review_cleanup() end,        { desc = "Cleanup PR review" } },
            { "<leader>pi", function() pr.info() end,                  { desc = "Show PR info" } },
            { "<leader>po", function() pr.open() end,                  { desc = "Open PR in browser" } },
            { "<leader>pb", function() pr.review_buffer() end,         { desc = "Toggle review buffer" } },

            { "<leader>pC", function() pr.line_comment() end,          { desc = "Add line comment" } },
            { "<leader>pP", function() pr.pending_comment() end,       { desc = "Add pending comment" } },
            { "<leader>pv", function() pr.list_all_comments() end,     { desc = "List all comments" } },
            { "<leader>pp", function() pr.list_pending_comments() end, { desc = "List pending comments" } },
            { "<leader>pR", function() pr.reply() end,                 { desc = "Reply to comment" } },
            { "<leader>pe", function() pr.edit_comment() end,          { desc = "Edit my comment" } },
            { "<leader>pd", function() pr.delete_comment() end,        { desc = "Delete my comment" } },

            { "<leader>pa", function() pr.approve() end,               { desc = "Approve PR" } },
            { "<leader>px", function() pr.request_changes() end,       { desc = "Request changes" } },
        }
        -- stylua: ignore end
    end,
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
