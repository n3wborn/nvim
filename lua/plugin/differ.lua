local vim_pack = require('vim-pack')

vim_pack.on_plugin_update('differ.nvim', { 'make', 'go-build' })

vim_pack.add({
    {
        src = 'undont/differ.nvim',
        opts = {},
        on_setup = function()
            local function map(lhs, rhs, desc)
                vim.keymap.set('n', lhs, rhs, { desc = desc })
            end

            -- local diff / history
            map('<space>do', '<cmd>Differ HEAD<CR>', 'Diff: open (vs index)')
            map('<space>dc', '<cmd>Differ close<CR>', 'Diff: close')
            map('<space>dt', '<cmd>Differ base<CR>', 'Diff: branch total (vs base)')
            map('<space>de', '<cmd>Differ gofile<CR>', 'Diff: open the real file')
            map('<space>dd', '<cmd>Differ panel<CR>', 'Diff: panel toggle')
            map('<space>dh', '<cmd>Differ log<CR>', 'Diff: file history')
            map('<space>dp', '<cmd>Differ log origin/HEAD...HEAD<CR>', 'Diff: PR range (local, no API)')
            map('<space>dl', '<cmd>Differ layout<CR>', 'Diff: toggle layout')
            -- pr review (sidecar + github)
            map('<space>pl', '<cmd>Differ pr list<CR>', 'PR: list')
            map('<space>po', function()
                vim.ui.input({ prompt = 'PR number: ' }, function(input)
                    if input and input ~= '' then
                        vim.cmd('Differ pr ' .. input)
                    end
                end)
            end, 'PR: open by number')
            map('<space>pr', '<cmd>Differ pr review<CR>', 'PR: review start')
            map('<space>pe', '<cmd>Differ pr review resume<CR>', 'PR: review resume')
            map('<space>pm', '<cmd>Differ pr review submit<CR>', 'PR: review submit')
            map('<space>pd', '<cmd>Differ pr review discard<CR>', 'PR: review discard')
            map('<space>psm', '<cmd>Differ pr merge squash<CR>', 'PR: squash merge')
            map('<space>pk', '<cmd>Differ pr checks<CR>', 'PR: checks')
            map('<space>pO', '<cmd>Differ pr checkout<CR>', 'PR: checkout')
            map('<space>pR', '<cmd>Differ pr ready<CR>', 'PR: mark ready')
            map('<space>pD', '<cmd>Differ pr draft<CR>', 'PR: mark draft')
            map('<space>pX', '<cmd>Differ pr close<CR>', 'PR: close')
            map('<space>pb', '<cmd>Differ pr browser<CR>', 'PR: open in browser')
            map('<space>py', '<cmd>Differ pr url<CR>', 'PR: yank URL')
            map('<space>pq', '<cmd>Differ close<CR>', 'PR: quit')
        end,
    },
})
