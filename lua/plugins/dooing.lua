---@type LazyPluginSpec
return {
    'atiladefreitas/dooing',
    cmd = {
        'Dooing',
        'DooingLocal',
    },
    keys = {
        { '<leader>td', '<cmd>DooingLocal<cr>', desc = 'Open/toggle Project Todos' },
        { '<leader>tD', '<cmd>Dooing<cr>', desc = 'Open/toggle Global Todos' },
    },
    opts = {
        ui = {
            style = 'modern',
            icons = {
                priority_bar = '▏',
                overdue = '󰀦',
                progress_on = '▰',
                progress_off = '▱',
            },
        },
        window = {
            dimensions = function()
                return {
                    width = math.max(40, math.floor(vim.o.columns * 0.6)),
                    height = math.max(10, math.floor(vim.o.lines * 0.8)),
                }
            end,
        },
        keymaps = {
            toggle_window = '<leader>tD', -- Toggle global todos
            open_project_todo = '<leader>td', -- Toggle project-specific todos
            show_due_notification = '<leader>tN', -- Show due items window
            new_todo = 'i',
            create_nested_task = '<leader>tn', -- Create nested subtask under current todo
            toggle_todo = 'x',
            delete_todo = 'd',
            delete_completed = 'D',
            close_window = 'q',
            undo_delete = 'u',
            add_due_date = 'H',
            remove_due_date = 'r',
            toggle_help = '?',
            toggle_tags = 't',
            toggle_priority = '<Space>',
            clear_filter = 'c',
            edit_todo = 'e',
            edit_tag = 'e',
            edit_priorities = 'p',
            delete_tag = 'd',
            search_todos = '/',
            add_time_estimation = 'T',
            remove_time_estimation = 'R',
            import_todos = 'I',
            export_todos = 'E',
            remove_duplicates = '<leader>D',
            open_todo_scratchpad = '<leader>p',
            refresh_todos = 'f',
        },
        per_project = {
            enabled = true, -- Enable per-project todos
            default_filename = 'dooing.json', -- Default filename for project todos
            auto_gitignore = false, -- Auto-add to .gitignore (true/false/"prompt")
            on_missing = 'prompt', -- What to do when file missing ("prompt"/"auto_create")
            auto_open_project_todos = false, -- Auto-open project todos on startup if they exist
        },
    },
}
