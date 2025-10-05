---@type LazyPluginSpec
return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Oil',
    event = 'VeryLazy',
    opts = {
        prompt_save_on_select_new_entry = false,
        columns = { 'icon' },
        keymaps = {
            ['<C-h>'] = false,
            ['<M-h>'] = 'actions.select_split',
        },
        view_options = {
            show_hidden = true,
        },
    },
    keys = {
        {
            '-',
            function()
                require('oil').open()
            end,
            { desc = 'Open parent directory' },
        },
        {
            '<space>-',
            function()
                require('oil').open()
            end,
            { desc = 'Open Float window' },
        },
    },
}
