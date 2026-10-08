-- NOTE: nvim-dap was marked `optional = true` in the lazy.nvim spec, so it was never installed
-- and this whole debug setup was inactive. Its <leader>d* keymaps also clash with dadbod-grip
-- (<leader>db, <leader>dg, <leader>ds, <leader>dt). Remove this guard once the keymaps are sorted out.
do
    return
end

local add = require('vim-pack').add

add({
    { src = 'nvim-lua/plenary.nvim', setup = false },
    { src = 'nvim-neotest/nvim-nio', setup = false },
    { src = 'williamboman/mason.nvim' },
    {
        src = 'jay-babu/mason-nvim-dap.nvim',
        module_name = 'mason-nvim-dap',
        opts = {
            automatic_installation = true,
            ensure_installed = {
                'php',
            },
        },
    },
    {
        src = 'mfussenegger/nvim-dap',
        setup = false,
        on_setup = function()
            local dap = require('dap')
            dap.adapters.php = {
                type = 'executable',
                command = 'node',
                args = { vim.env.HOME .. '/div/bin/vscode-php-debug/out/phpDebug.js' },
            }

            vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
            local icons = {
                Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
                Breakpoint = ' ',
                BreakpointCondition = ' ',
                BreakpointRejected = { ' ', 'DiagnosticError' },
                LogPoint = '.>',
            }
            for name, sign in pairs(icons) do
                sign = type(sign) == 'table' and sign or { sign }
                vim.fn.sign_define(
                    'Dap' .. name,
                    { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
                )
            end

            -- setup dap config by VsCode launch.json file
            local vscode = require('dap.ext.vscode')
            local json = require('plenary.json')
            vscode.json_decode = function(str)
                return vim.json.decode(json.json_strip_comments(str))
            end

            -- stylua: ignore start
            vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Breakpoint Condition' })
            vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = 'Run/Continue' })
            vim.keymap.set('n', '<leader>dC', function() dap.run_to_cursor() end, { desc = 'Run to Cursor' })
            vim.keymap.set('n', '<leader>dg', function() dap.goto_() end, { desc = 'Go to Line (No Execute)' })
            vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = 'Step Into' })
            vim.keymap.set('n', '<leader>dj', function() dap.down() end, { desc = 'Down' })
            vim.keymap.set('n', '<leader>dk', function() dap.up() end, { desc = 'Up' })
            vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Run Last' })
            vim.keymap.set('n', '<leader>do', function() dap.step_out() end, { desc = 'Step Out' })
            vim.keymap.set('n', '<leader>dO', function() dap.step_over() end, { desc = 'Step Over' })
            vim.keymap.set('n', '<leader>dP', function() dap.pause() end, { desc = 'Pause' })
            vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, { desc = 'Toggle REPL' })
            vim.keymap.set('n', '<leader>ds', function() dap.session() end, { desc = 'Session' })
            vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, { desc = 'Terminate' })
            vim.keymap.set('n', '<leader>dw', function() require('dap.ui.widgets').hover() end, { desc = 'Widgets' })
            -- stylua: ignore end
        end,
    },
    { src = 'theHamsta/nvim-dap-virtual-text', opts = {} },
    {
        src = 'rcarriga/nvim-dap-ui',
        module_name = 'dapui',
        opts = {},
        on_setup = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close({})
            end

            -- stylua: ignore start
            vim.keymap.set('n', '<leader>du', function() dapui.toggle({}) end, { desc = 'Dap UI' })
            vim.keymap.set({ 'n', 'v' }, '<leader>de', function() dapui.eval() end, { desc = 'Eval' })
            -- stylua: ignore end
        end,
    },
})
