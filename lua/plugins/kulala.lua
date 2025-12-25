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
    opts = {
        global_keymaps = {
            -- @TODO improve these mappings (put them in keys spec ?)
            ['Send request'] = {
                '<space>RR',
                function()
                    require('kulala').run()
                end,
                mode = { 'n', 'v' }, -- optional mode, default is n
                desc = 'Send request', -- optional description, otherwise inferred from the key
            },
            ['Send all requests'] = {
                '<space>Ra',
                function()
                    require('kulala').run_all()
                end,
                mode = { 'n', 'v' },
                ft = 'http', -- sets mapping for *.http files only
            },
            ['Replay the last request'] = {
                '<space>Rr',
                function()
                    require('kulala').replay()
                end,
                ft = { 'http', 'rest' }, -- sets mapping for specified file types
            },
            ['Find request'] = false, -- set to false to disable
        },
    },
}
