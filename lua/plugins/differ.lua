---@type LazyPluginSpec
return {
    'undont/differ.nvim',
    build = 'make go-build',
    cmd = { 'Differ' },
    keys = {
        -- local diff / history
        { '<space>do', '<cmd>Differ HEAD<CR>', desc = 'Diff: open (vs index)' },
        { '<space>dc', '<cmd>Differ close<CR>', desc = 'Diff: close' },
        { '<space>dt', '<cmd>Differ base<CR>', desc = 'Diff: branch total (vs base)' },
        { '<space>de', '<cmd>Differ gofile<CR>', desc = 'Diff: open the real file' },
        { '<space>dd', '<cmd>Differ panel<CR>', desc = 'Diff: panel toggle' },
        { '<space>dh', '<cmd>Differ log<CR>', desc = 'Diff: file history' },
        { '<space>dp', '<cmd>Differ log origin/HEAD...HEAD<CR>', desc = 'Diff: PR range (local, no API)' },
        { '<space>dl', '<cmd>Differ layout<CR>', desc = 'Diff: toggle layout' },
        -- pr review (sidecar + github)
        { '<space>pl', '<cmd>Differ pr list<CR>', desc = 'PR: list' },
        {
            '<space>po',
            function()
                vim.ui.input({ prompt = 'PR number: ' }, function(input)
                    if input and input ~= '' then
                        vim.cmd('Differ pr ' .. input)
                    end
                end)
            end,
            desc = 'PR: open by number',
        },
        { '<space>pr', '<cmd>Differ pr review<CR>', desc = 'PR: review start' },
        { '<space>pe', '<cmd>Differ pr review resume<CR>', desc = 'PR: review resume' },
        { '<space>pm', '<cmd>Differ pr review submit<CR>', desc = 'PR: review submit' },
        { '<space>pd', '<cmd>Differ pr review discard<CR>', desc = 'PR: review discard' },
        { '<space>psm', '<cmd>Differ pr merge squash<CR>', desc = 'PR: squash merge' },
        { '<space>pk', '<cmd>Differ pr checks<CR>', desc = 'PR: checks' },
        { '<space>pO', '<cmd>Differ pr checkout<CR>', desc = 'PR: checkout' },
        { '<space>pR', '<cmd>Differ pr ready<CR>', desc = 'PR: mark ready' },
        { '<space>pD', '<cmd>Differ pr draft<CR>', desc = 'PR: mark draft' },
        { '<space>pX', '<cmd>Differ pr close<CR>', desc = 'PR: close' },
        { '<space>pb', '<cmd>Differ pr browser<CR>', desc = 'PR: open in browser' },
        { '<space>py', '<cmd>Differ pr url<CR>', desc = 'PR: yank URL' },
        { '<space>pq', '<cmd>Differ close<CR>', desc = 'PR: quit' },
    },
    opts = {},
}
