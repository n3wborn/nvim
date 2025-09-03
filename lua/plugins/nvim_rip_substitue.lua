---@type LazyPluginSpec
return {
    'chrisgrieser/nvim-rip-substitute',
    cmd = 'RipSubstitute',
    opts = {
        keymaps = { -- normal mode (if not stated otherwise)
            abort = 'q',
            confirm = '<CR>',
            insertModeConfirm = '<M-CR>',
            prevSubstitutionInHistory = '<Up>',
            nextSubstitutionInHistory = '<Down>',
            toggleFixedStrings = '<C-f>', -- ripgrep's `--fixed-strings`
            toggleIgnoreCase = '<C-c>', -- ripgrep's `--ignore-case`
            openAtRegex101 = 'R',
            showHelp = '?',
        },
    },
    keys = {
        {
            '<leader>fs',
            function()
                require('rip-substitute').sub()
            end,
            mode = { 'n', 'x' },
            desc = ' rip substitute',
        },
    },
}
