---@type LazyPluginSpec
return {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = true,
    -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
    -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
    -- spec defers loading until a <leader>a* mapping is pressed and the commands
    -- would not exist yet.
    cmd = {
        'ClaudeCode',
        'ClaudeCodeFocus',
        'ClaudeCodeSelectModel',
        'ClaudeCodeAdd',
        'ClaudeCodeSend',
        'ClaudeCodeTreeAdd',
        'ClaudeCodeStatus',
        'ClaudeCodeStart',
        'ClaudeCodeStop',
        'ClaudeCodeOpen',
        'ClaudeCodeClose',
        'ClaudeCodeDiffAccept',
        'ClaudeCodeDiffDeny',
        'ClaudeCodeCloseAllDiffs',
    },
    keys = {
        { '<leader>a', nil, desc = 'AI/Claude Code' },
        { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
        { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
        { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
        { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
        { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
        { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
        { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
        {
            '<leader>as',
            '<cmd>ClaudeCodeTreeAdd<cr>',
            desc = 'Add file',
            ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw', 'snacks_picker_list' },
        },
        -- Diff management
        { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
        { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
}
