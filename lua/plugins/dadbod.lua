return {
    ---@type LazyPluginSpec
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    ---@type LazyPluginSpec
    {
        'joryeugene/dadbod-grip.nvim',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
        },
        keys = {
            { '<leader>db', '<cmd>GripConnect<cr>', desc = 'DB connect' },
            { '<leader>dg', '<cmd>Grip<cr>', desc = 'DB grid' },
            { '<leader>dt', '<cmd>GripTables<cr>', desc = 'DB tables' },
            { '<leader>dq', '<cmd>GripQuery<cr>', desc = 'DB query pad' },
            { '<leader>ds', '<cmd>GripSchema<cr>', desc = 'DB schema' },
            { '<leader>dh', '<cmd>GripHistory<cr>', desc = 'DB history' },
        },
        cmd = {
            'Grip',
            'GripStart',
            'GripHome',
            'GripConnect',
            'GripSchema',
            'GripTables',
            'GripQuery',
            'GripSave',
            'GripLoad',
            'GripHistory',
            'GripProfile',
            'GripExplain',
            'GripAsk',
            'GripDiff',
            'GripCreate',
            'GripDrop',
            'GripRename',
            'GripProperties',
            'GripExport',
            'GripAttach',
            'GripDetach',
            'GripOpen',
        },

        opts = {},
    },
    ---@type LazyPluginSpec
    {
        'saghen/blink.cmp',
        opts = {
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                per_filetype = {
                    sql = { 'snippets', 'dadbod', 'buffer' },
                },
                providers = {
                    dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
                },
            },
        },
    },
}
