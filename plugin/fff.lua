vim.api.nvim_create_autocmd('User', {
    pattern = 'PackChanged',
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        -- TODO: Check if process is ok !
        if name == 'fff.nvim' and kind == 'update' then
            if not ev.data.active then
                vim.cmd.packadd('fff.nvim')
            end

            require('fff.download').download_or_build_binary()
        end
    end,
})

vim.pack.add({ 'https://github.com/dmtrKovalenko/fff.nvim' })

require('fff').setup({
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
})

local u = require('utils')

u.map('n', 'ff', function()
    require('fff').find_files()
end, { desc = '[FFF] Find Files' })

u.map('n', '<space>sp', function()
    require('fff').live_grep()
end, { desc = '[FFF] [S]earch in [P]roject' })

u.map('n', '<space>sd', function()
    require('fff').live_grep({ query = vim.fn.expand('<cword>') })
end, { desc = '[FFF] Find Current Word' })
