---@type LazyPluginSpec
return {
    'dmtrKovalenko/fff.nvim',
    build = function()
        require('fff.download').download_or_build_binary() -- use gb on lazy to rebuild when needed
    end,
    opts = {
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
    },
    lazy = false, -- it already lazy-load itself
    keys = function()
        local fff = require('fff')
        local fuzzy = require('fff.core').ensure_initialized()

        return {
            {
                'ff',
                function()
                    local ok, git_root = pcall(fuzzy.get_git_root)

                    if ok and git_root then
                        fff.find_files()
                    else
                        vim.notify('Not in a git repository', vim.log.levels.WARN)
                        ---@diagnostic disable-next-line: param-type-mismatch
                        fff.find_files_in_dir(vim.uv.cwd())
                    end
                end,
                desc = '[FFF] Find Files',
            },
            {
                'fF',
                function()
                    fff.find_files()
                end,
                desc = '[FFF] Find files',
            },
            {
                '<space>sp',
                function()
                    fff.live_grep()
                end,
                desc = '[FFF] Find With Live Grep',
            },
            {
                '<space>sd',
                function()
                    fff.live_grep({ query = vim.fn.expand('<cword>') })
                end,
                desc = '[FFF] Find Current Word',
            },
        }
    end,
}
