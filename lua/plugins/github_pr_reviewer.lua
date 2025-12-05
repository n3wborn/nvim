return {
    'otavioschwanck/github-pr-reviewer.nvim',
    -- opts = {
    --     -- options here
    -- },
    keys = {
        { '<leader>p', '<cmd>PRReviewMenu<cr>', desc = 'PR Review Menu' },
        { '<leader>p', '<cmd>PRSuggestChange<CR>', desc = 'Suggest change', mode = 'v' },
    },
    config = function()
        require('github-pr-reviewer').setup({
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
        })
    end,
}
