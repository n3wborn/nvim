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
    opts = {
        icons = {
            inlay = {
                loading = '󰔛',
                done = '',
                error = '',
            },
            textHighlight = 'Comment',
        },
        ui = {
            win_opts = {
                wo = {
                    signcolumn = 'no',
                },
                bo = {
                    buflisted = true,
                },
            },
            syntax_hl = {
                ['@operator.kulala_http'] = 'Operator',
                ['@punctuation.bracket.kulala_http'] = '@punctuation.bracket',
                ['@variable.kulala_http'] = '@variable',
            },
        },
    },
    keys = function()
        local kulala = require('kulala')
        return {
            { '[r', kulala.jump_prev, desc = 'Goto next request' },
            { ']r', kulala.jump_next, desc = 'Goto prev request' },
            { '<leader>K', kulala.run, desc = 'Kulala Run' },
            { '<leader>Ka', kulala.run_all, desc = 'Kulala Run All' },
            { '<leader>Kr', kulala.replay, desc = 'Kulala Run All' },
            { '<leader>Ke', kulala.set_selected_env, desc = 'Kulala Env' },
            { '<leader>Kc', kulala.copy, desc = 'Kulala Copy (Curl)' },
            { '<leader>Kp', kulala.from_curl, desc = 'Kulala Paste (Curl)' },
        }
    end,
}
