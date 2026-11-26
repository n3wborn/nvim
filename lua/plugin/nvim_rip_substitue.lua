local add = require('vim-pack').add

add({
    {
        src = 'chrisgrieser/nvim-rip-substitute',
        module_name = 'rip-substitute',
        opts = {
            keymaps = { -- normal mode (if not stated otherwise)
                abort = 'q',
                confirmAndSubstituteInBuffer = '<CR>',
                insertModeConfirmAndSubstituteInBuffer = '<M-CR>',
                prevSubstitutionInHistory = '<Up>',
                nextSubstitutionInHistory = '<Down>',
                toggleFixedStrings = '<C-f>', -- ripgrep's `--fixed-strings`
                toggleIgnoreCase = '<C-c>', -- ripgrep's `--ignore-case`
                openAtRegex101 = 'R',
                showHelp = '?',
            },
        },
        on_setup = function()
            vim.keymap.set({ 'n', 'x' }, '<leader>fs', function()
                require('rip-substitute').sub()
            end, { desc = ' rip substitute' })
            vim.keymap.set('v', '<leader>fs', function()
                require('rip-substitute').sub()
            end, { desc = ' rip substitute selected range' })
        end,
    },
})
