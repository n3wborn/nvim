-- file.http exemple :
--
-- ### simple GET
--
-- GET https://jsonplaceholder.typicode.com/todos/1
--
-- ### get comments
--
-- GET https://jsonplaceholder.typicode.com/comments

---@type LazyPluginSpec
return {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    keys = function()
        local k = require('kulala')

        ---@as LazyKeys
        local keymaps = {
            { '<leader>K', k.run, { 'n', 'v' } },
            { '<leader>Ka', k.run_all, 'n' },
            { '<leader>Kr', k.replay, 'n' },
        }

        return keymaps
    end,
    opts = {},
}
