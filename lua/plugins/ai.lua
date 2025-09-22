---@type LazyPluginSpec
return {
    'xTacobaco/cursor-agent.nvim',
    ---@type string|string[]|LazyKeysSpec[]|fun(self:LazyPlugin, keys:string[]):((string|LazyKeys)[])
    keys = {
        { '<leader>ca', ':CursorAgent<CR>', mode = { 'n' }, desc = 'Cursor Agent: Toggle terminal' },
        { '<leader>ca', ':CursorAgentSelection<CR>', mode = { 'v' }, desc = 'Cursor Agent: Send selection' },
        { '<leader>cA', ':CursorAgentBuffer<CR>', mode = { 'n' }, desc = 'Cursor Agent: Send Buffer' },
    },
}
