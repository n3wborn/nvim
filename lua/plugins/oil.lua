---@type LazyPluginSpec
return {
    'stevearc/oil.nvim',
    dependencies = {
        'nvim-mini/mini.icons',
    },
    cmd = 'Oil',
    event = 'VeryLazy',
    opts = {
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = false,
        lsp_file_methods = {
            autosave_changes = true,
        },
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
                require('oil').open_float()
            end,
            { desc = 'Open Float window' },
        },
    },
}
