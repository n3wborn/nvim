vim.g.fff = {
    prompt = '🪿 ',
    layout = {
        height = 0.9,
        width = 0.9,
        prompt_position = 'top',
        preview_size = 0.6,
    },
    preview = {
        enabled = true,
        line_numbers = true,
    },
    debug = {
        enabled = false,
        show_scores = true,
    },
    grep = {
        max_matches_per_file = 1, -- 0 to unlimited
        time_budget_ms = 100, -- prevents UI freeze, 0 = no limit
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
        -- grep mode: cycle between plain text, regex, and fuzzy search
        cycle_grep_modes = '<S-Tab>',
        -- goes to the previous query in history
        cycle_previous_query = '<C-Up>',
        -- multi-select keymaps for quickfix
        toggle_select = '<Tab>',
        send_to_quickfix = '<C-q>',
        -- this are specific for the normal mode (you can exit it using any other keybind like jj)
        focus_list = '<leader>l',
        focus_preview = '<leader>p',
    },
    file_picker = {
        current_file_label = '(current)',
    },
}

---@type LazyPluginSpec
return {
    'dmtrKovalenko/fff.nvim',
    build = function()
        require('fff.download').download_or_build_binary() -- use gb on lazy to rebuild when needed
    end,
    lazy = false, -- it already lazy-load itself
    keys = {
        {
            'ff',
            function()
                local fuzzy = require('fff.core').ensure_initialized()
                local ok, git_root = pcall(fuzzy.get_git_root)

                if ok and git_root then
                    require('fff').find_files()
                else
                    vim.notify('Not in a git repository', vim.log.levels.WARN)
                    require('fff').find_files_in_dir(vim.uv.cwd())
                end
            end,
            desc = '[FFF] Find Files',
        },
        {
            'fF',
            function()
                require('fff').find_files()
            end,
            desc = '[FFF] Find files',
        },
        {
            '<space>sp',
            function()
                require('fff').live_grep()
            end,
            desc = '[FFF] Find With Live Grep',
        },
        {
            '<space>sd',
            function()
                local word = vim.fn.expand('<cword>')
                if word == '' then
                    word = vim.fn.expand('<cWORD>')
                end

                require('fff').live_grep({ query = word })
            end,
            desc = '[FFF] Find Current Word',
        },
    },
}
