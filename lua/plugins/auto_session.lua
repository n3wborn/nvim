---@type LazyPluginSpec
return {
    'rmagatti/auto-session',
    enabled = true,
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        allowed_dirs = { '~/.config/nvim', '~/.local/share/nvim/', '~/prog/git/*' },
        lazy_support = true,
        auto_restore = true,
        auto_create = true,
        auto_restore_last_session = true,
        git_use_branch_name = true,
        bypass_save_filetypes = { 'snacks_dashboard' },
        extensions = { 'quickfix', 'fzf', 'lazy', 'neo-tree', 'nvim-dap-ui', 'oil' },
    },
    keys = {
        { '<leader>sL', ':AutoSession search<CR>', desc = 'List sessions' },
        { '<leader>sS', ':AutoSession save', desc = 'Save session' },
        { '<leader>sD', ':AutoSession delete', desc = 'Delete session' },
        { '<leader>sr', ':AutoSession restore', desc = 'Restore session' },
    },
}
