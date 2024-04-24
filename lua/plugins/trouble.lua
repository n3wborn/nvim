return {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    branch = 'dev',
    opts = {
        auto_close = false, -- auto close when there are no items
        auto_open = false, -- auto open when there are items
        auto_preview = true, -- automatically open preview when on an item
        auto_refresh = true, -- auto refresh when open
        focus = true, -- Focus the window when opened
        follow = true, -- Follow the current item
        indent_guides = true, -- show indent guides
        max_items = 100, -- limit number of items that can be displayed per section
        multiline = true, -- render multi-line messages
        pinned = true, -- When pinned, the opened trouble window will be bound to the current buffer
    },
    config = function(_, opts)
        require('trouble').setup(opts)
    end,
}
