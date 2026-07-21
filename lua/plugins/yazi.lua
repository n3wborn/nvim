---@type LazySpec
return {
    'mikavilpas/yazi.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim', lazy = true },
    },
    event = 'VeryLazy',
    cmd = {
        'Yazi',
    },
    keys = {
        {
            '<leader>e',
            mode = { 'n', 'v' },
            '<cmd>Yazi<cr>',
            desc = 'Open yazi at the current file',
        },
    },
    ---@module 'yazi'
    ---@type YaziConfig
    opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = true,
        keymaps = {
            show_help = '<f1>',
            open_file_in_vertical_split = '<c-v>',
            open_file_in_horizontal_split = '<c-s>',
            open_file_in_tab = '<c-t>',
            grep_in_directory = false,
            cycle_open_buffers = '<tab>',
            copy_relative_path_to_selected_files = '<c-y>',
            send_to_quickfix_list = '<c-q>',
            change_working_directory = '<c-\\>',
            open_and_pick_window = '<c-o>',
        },
    },
}
