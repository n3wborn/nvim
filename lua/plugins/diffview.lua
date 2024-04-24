return {
    'sindrets/diffview.nvim',
    cmd = {
        'DiffviewOpen',
        'DiffviewClose',
        'DiffviewRefresh',
        'DiffviewFileHistory',
        'DiffviewFocusFiles',
        'DiffviewToggleFiles',
    },
    config = function()
        require('diffview')
    end,
}
