vim.pack.add({ 'https://github.com/dmtrKovalenko/fff.nvim' })

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(event)
        if event.data.updated then
            require('fff.download').download_or_build_binary()
        end
    end,
})

-- the plugin will automatically lazy load
vim.g.fff = {
    prompt = '🪿 ',
    layout = {
        height = 0.9,
        width = 0.9,
        prompt_position = 'top', -- 'bottom', 'top'
        preview_position = 'right', -- 'left', 'right', 'top', 'bottom'
        preview_size = 0.6,
        show_scrollbar = false,
        -- How to shorten long directory paths in the file list:
        -- 'middle_number' (default): uses dots for 1-3 hidden (a/./b, a/../b, a/.../b)
        --                            and numbers for 4+ (a/.4./b, a/.5./b)
        -- 'middle': always uses dots (a/./b, a/../b, a/.../b)
        -- 'end': truncates from the end (home/user/projects)
        path_shorten_strategy = 'middle_number',
    },
    preview = {
        enabled = true,
        max_size = 8 * 10 * 1024 * 1024, -- Do not try to read files larger than 80MB
        chunk_size = 8192, -- Bytes per chunk for dynamic loading (8kb - fits ~100-200 lines)
        binary_file_threshold = 0, -- amount of bytes to scan for binary content (set 0 to disable)
        imagemagick_info_format_str = '%m: %wx%h, %[colorspace], %q-bit',
        line_numbers = true,
        cursorlineopt = 'both', -- the cursorlineopt used for lines in grep file previews, see :h cursorlineopt
    },
    debug = {
        enabled = true,
        show_scores = true,
    },
    grep = {
        max_file_size = 8 * 10 * 1024 * 1024, -- Skip files larger than 80MB
        max_matches_per_file = 100, -- 0 to unlimited
        smart_case = true,
        time_budget_ms = 150, -- prevents UI freeze, 0 = no limit
    },
}

local fff = require('fff')

vim.keymap.set('n', 'ff', function()
    local fuzzy = fff.ensure_initialized()
    local ok, git_root = pcall(fuzzy.get_git_root)

    if ok and git_root then
        fff.find_files()
    else
        vim.notify('Not in a git repository', vim.log.levels.WARN)
        ---@diagnostic disable-next-line: param-type-mismatch
        fff.find_files_in_dir(vim.uv.cwd())
    end
end, { desc = 'FFFind files' })

vim.keymap.set('n', '<space>sp', fff.live_grep, { desc = '[FFF] Find With Live Grep' })

vim.keymap.set('n', '<space>sd', function()
    fff.live_grep({ query = vim.fn.expand('<cword>') })
end, { desc = '[FFF] Find With Live Grep' })
