---@type LazyPluginSpec
return {
    'xTacobaco/cursor-agent.nvim',
    ---@type string|string[]|LazyKeysSpec[]|fun(self:LazyPlugin, keys:string[]):((string|LazyKeys)[])
    keys = {
        { '<leader>ca', ':CursorAgent<CR>', mode = { 'n' }, desc = 'Cursor Agent: Toggle terminal' },
        { '<leader>ca', ':CursorAgentSelection<CR>', mode = { '' }, desc = 'Cursor Agent: Sens selection' },
        { '<leader>ca', ':CursorAgentBuffer<CR>', mode = { 'n' }, desc = 'Cursor Agent: Send Buffer' },
    },
}
