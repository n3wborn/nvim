return {
    src = 'https://github.com/dmtrKovalenko/fff.nvim',
    data = {
        setup = function()
            require('fff').setup({
                base_path = vim.fn.getcwd(),
                prompt = '🪿 ',
                title = 'FFFiles',
                max_results = 100,
                max_threads = 4,
                lazy_sync = false, -- set to false if you want file indexing to start on open
                layout = {
                    height = 0.8,
                    width = 0.8,
                    prompt_position = 'top', -- or 'top'
                    preview_position = 'right', -- or 'left', 'right', 'top', 'bottom'
                    preview_size = 0.5,
                    show_scrollbar = true, -- Show scrollbar for pagination
                },
                preview = {
                    enabled = true,
                    max_size = 2 * 10 * 1024 * 1024, -- Do not try to read files larger than 10MB
                    chunk_size = 8192, -- Bytes per chunk for dynamic loading (8kb - fits ~100-200 lines)
                    binary_file_threshold = 1024, -- amount of bytes to scan for binary content (set 0 to disable)
                    imagemagick_info_format_str = '%m: %wx%h, %[colorspace], %q-bit',
                    line_numbers = true,
                    wrap_lines = false,
                    filetypes = {
                        svg = { wrap_lines = true },
                        markdown = { wrap_lines = true },
                        text = { wrap_lines = true },
                    },
                },
                keymaps = {
                    close = '<Esc>',
                    select = '<CR>',
                    select_split = '<C-s>',
                    select_vsplit = '<C-v>',
                    select_tab = '<C-t>',
                    -- you can assign multiple keys to any action
                    move_up = { '<Up>', '<C-p>' },
                    move_down = { '<Down>', '<C-n>' },
                    preview_scroll_up = '<C-u>',
                    preview_scroll_down = '<C-d>',
                    toggle_debug = '<F2>',
                    -- goes to the previous query in history
                    cycle_previous_query = '<C-Up>',
                    -- multi-select keymaps for quickfix
                    toggle_select = '<Tab>',
                    send_to_quickfix = '<C-q>',
                },
            })
        end,

        vim.keymap.set('n', 'ff', function()
            require('fff').find_files()
        end, { desc = 'FFFind files' }),
    },
}
