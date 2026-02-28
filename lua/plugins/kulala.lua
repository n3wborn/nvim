-- Kulala will be loaded on http/rest filetypes but also from http injected code !
--
-- ```http
-- # simple GET
-- GET https://jsonplaceholder.typicode.com/todos/1
--
-- # get comments
-- GET https://jsonplaceholder.typicode.com/comments
-- ```

---@type LazyPluginSpec
return {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    keys = {
        {
            '<leader>K',
            function()
                require('kulala').run()
            end,
            { 'n', 'v' },
        },
        {
            '<leader>Ka',
            function()
                require('kulala').run_all()
            end,
            { 'n' },
        },
        {
            '<leader>Kr',
            function()
                require('kulala').replay()
            end,
            { 'n' },
        },
    },
}
