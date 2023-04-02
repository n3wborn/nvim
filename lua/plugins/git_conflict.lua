-- https://github.com/akinsho/git-conflict.nvim
local ok, conflict = pcall(require, 'git-conflict')

if not ok then
    return
end

conflict.setup({
    default_mappings = {
        ours = 'o',
        theirs = 't',
        none = '0',
        both = 'b',
        next = 'n',
        prev = 'p',
    },
    default_commands = true,
    disable_diagnostics = false,
    highlights = {
        incoming = 'DiffText',
        current = 'DiffAdd',
    },
})

--[[
    co — choose ours
    ct — choose theirs
    cb — choose both
    c0 — choose none
    ]x — move to previous conflict
    [x — move to next conflict

    vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)')
    vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)')
    vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)')
    vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)')
    vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)')
    vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)')
 ]]
