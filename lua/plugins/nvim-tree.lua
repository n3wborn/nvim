-- Nvim-Tree

local g = vim.g

g.nvim_tree_add_trailing         = 0
g.nvim_tree_auto_close           = 1
g.nvim_tree_auto_open            = 0
g.nvim_tree_disable_netrw        = 1
g.nvim_tree_follow               = 1
g.nvim_tree_git_hl               = 1
g.nvim_tree_gitignore            = 1
g.nvim_tree_group_empty          = 1
g.nvim_tree_hide_dotfiles        = 0
g.nvim_tree_hijack_netrw         = 1
g.nvim_tree_ignore               = {'.git', 'node_modules', '.cache'}
g.nvim_tree_indent_markers       = 1
g.nvim_tree_lsp_diagnostics      = 1
g.nvim_tree_quit_on_open         = 0
g.nvim_tree_root_folder_modifier = ':~'
g.nvim_tree_side                 = 'left'
g.nvim_tree_tab_open             = 1
g.nvim_tree_width                = 30
g.nvim_tree_width_allow_resize   = 0

g.nvim_tree_window_picker_exclude = {
    filetype = {
        "packer",
        "qf"
    }
}

g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    folder_arrows = 1,
    files = 1,
}

