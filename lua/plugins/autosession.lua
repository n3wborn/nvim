return {
    'rmagatti/auto-session',
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        allowed_dirs = { '~/.config/', '~/prog/', '~/projets' },
        auto_restore_last_session = true,
        close_filetypes_on_save = { 'checkhealth' },

        -- Git / Session naming
        git_use_branch_name = true,
        git_auto_restore_on_branch_change = true,
        show_auto_restore_notif = false,

        ---@type SessionLens
        session_lens = {
            picker = 'fzf',
            load_on_setup = true,
            previewer = 'summary',

            ---@type SessionLensMappings
            mappings = {
                delete_session = { 'i', '<C-d>' },
                alternate_session = { 'i', '<C-s>' },
                copy_session = { 'i', '<C-y>' },
            },

            ---@type SessionControl
            session_control = {
                control_dir = vim.fn.stdpath('data') .. '/auto_session/',
                control_filename = 'session_control.json',
            },
        },
    },
}
