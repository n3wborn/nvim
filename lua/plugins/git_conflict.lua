return {
    'akinsho/git-conflict.nvim',
    event = 'BufReadPre',
    opts = {
        disable_diagnostics = true,
        --[[
            MAPPINGS

            co — choose ours
            ct — choose theirs
            cb — choose both
            c0 — choose none
            ]x — move to previous conflict
            [x — move to next conflict
        ]]
    },
}
