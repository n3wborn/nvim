return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    opts = function()
        local actions = require('fzf-lua.actions')

        return {
            -- Make stuff better combine with the editor.
            fzf_colors = {
                bg = { 'bg', 'Normal' },
                gutter = { 'bg', 'Normal' },
                info = { 'fg', 'Conditional' },
                scrollbar = { 'bg', 'Normal' },
                separator = { 'fg', 'Comment' },
            },
            fzf_opts = {
                ['--info'] = 'default',
                ['--layout'] = 'reverse-list',
            },
            keymap = {
                builtin = {
                    ['<C-/>'] = 'toggle-help',
                    ['<C-a>'] = 'toggle-fullscreen',
                    ['<C-i>'] = 'toggle-preview',
                    ['<C-f>'] = 'preview-page-down',
                    ['<C-b>'] = 'preview-page-up',
                },
                fzf = {
                    ['alt-s'] = 'toggle',
                    ['alt-a'] = 'toggle-all',
                },
            },
            winopts = {
                height = 0.7,
                width = 0.55,
                preview = {
                    scrollbar = false,
                    layout = 'vertical',
                    vertical = 'up:40%',
                },
            },
            global_git_icons = false,
            -- Configuration for specific commands.
            files = {
                winopts = {
                    preview = { hidden = 'hidden' },
                },
                actions = {
                    ['ctrl-g'] = actions.toggle_ignore,
                },
            },
            helptags = {
                actions = {
                    -- Open help pages in a vertical split.
                    ['default'] = actions.help_vert,
                },
            },
            lsp = {
                code_actions = {
                    previewer = 'codeaction_native',
                    preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
                },
                symbols = {
                    symbol_icons = require('custom.icons').kinds,
                },
            },
            oldfiles = {
                include_current_session = true,
                winopts = {
                    preview = { hidden = 'hidden' },
                },
            },
        }
    end,
    config = function()
        -- calling `setup` is optional for customization
        require('fzf-lua').setup({})
    end,
}
