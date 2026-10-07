-- https://github.com/saikocat/dotfiles/blob/master/neovim/.config/nvim/lua/plugins/code/treesitter_textobjects_keymaps.lua
local M = {}
local u = require('utils')

function M.setup()
    local map = function(modes, lhs, rhs, opts)
        opts = vim.tbl_extend('force', { silent = true, noremap = true }, opts or {})
        vim.keymap.set(modes, lhs, rhs, opts)
    end

    -- Require once (assumes this runs after the plugin is loaded)
    local select = require('nvim-treesitter-textobjects.select')
    local move = require('nvim-treesitter-textobjects.move')
    local rep = require('nvim-treesitter-textobjects.repeatable_move')

    -- Factories (return a function for vim.keymap.set)
    local sel = function(capture, group)
        return function()
            select.select_textobject(capture, group or 'textobjects')
        end
    end

    local mv = function(method, capture, group)
        return u.center(function()
            move[method](capture, group or 'textobjects')
        end)
    end

    local mv_any = function(method, captures, group)
        return u.center(function()
            move[method](captures, group or 'textobjects')
        end)
    end

    -- Keep the native motion (e.g. ]c / [c: next/prev change) in diff mode
    local diff_or = function(native, fn)
        return function()
            if vim.wo.diff then
                vim.cmd.normal({ vim.v.count1 .. native, bang = true })
            else
                fn()
            end
        end
    end

    -- Select
    local select_maps = {
        { { 'x', 'o' }, 'af', sel('@function.outer'), { desc = 'TS: around function' } },
        { { 'x', 'o' }, 'if', sel('@function.inner'), { desc = 'TS: inside function' } },
        { { 'x', 'o' }, 'ac', sel('@class.outer'), { desc = 'TS: around class' } },
        { { 'x', 'o' }, 'ic', sel('@class.inner'), { desc = 'TS: inside class' } },
        { { 'x', 'o' }, 'as', sel('@local.scope', 'locals'), { desc = 'TS: around scope' } },
    }

    -- Move
    local move_maps = {
        { { 'n', 'x', 'o' }, ']m', mv('goto_next_start', '@function.outer'), { desc = 'TS: next function start' } },
        { { 'n', 'x', 'o' }, ']]', mv('goto_next_start', '@class.outer'), { desc = 'TS: next class start' } },
        { { 'n', 'x', 'o' }, ']s', mv('goto_next_start', '@local.scope', 'locals'), { desc = 'TS: next scope start' } },
        { { 'n', 'x', 'o' }, ']z', mv('goto_next_start', '@fold', 'folds'), { desc = 'TS: next fold start' } },

        { { 'n', 'x', 'o' }, ']M', mv('goto_next_end', '@function.outer'), { desc = 'TS: next function end' } },
        { { 'n', 'x', 'o' }, '][', mv('goto_next_end', '@class.outer'), { desc = 'TS: next class end' } },

        { { 'n', 'x', 'o' }, '[m', mv('goto_previous_start', '@function.outer'), { desc = 'TS: prev function start' } },
        { { 'n', 'x', 'o' }, '[[', mv('goto_previous_start', '@class.outer'), { desc = 'TS: prev class start' } },

        { { 'n', 'x', 'o' }, '[M', mv('goto_previous_end', '@function.outer'), { desc = 'TS: prev function end' } },
        { { 'n', 'x', 'o' }, '[]', mv('goto_previous_end', '@class.outer'), { desc = 'TS: prev class end' } },

        -- "nearest of start/end"
        {
            { 'n', 'x', 'o' },
            ']c',
            diff_or(']c', mv('goto_next', '@conditional.outer')),
            { desc = 'TS: next conditional (next change in diff)' },
        },
        {
            { 'n', 'x', 'o' },
            '[c',
            diff_or('[c', mv('goto_previous', '@conditional.outer')),
            { desc = 'TS: prev conditional (prev change in diff)' },
        },

        -- Grouped captures example
        {
            { 'n', 'x', 'o' },
            ']o',
            mv_any('goto_next_start', { '@loop.inner', '@loop.outer' }),
            { desc = 'TS: next loop start' },
        },
    }

    require('nvim-treesitter-textobjects').setup({
        move = {
            -- whether to set jumps in the jumplist
            set_jumps = true,
        },

        select = {
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = false,
        },
    })

    -- Apply all the maps
    for _, m in ipairs(select_maps) do
        map(m[1], m[2], m[3], m[4])
    end

    for _, m in ipairs(move_maps) do
        map(m[1], m[2], m[3], m[4])
    end

    -- Repeatable ; only: ',' is the mapleader
    map({ 'n', 'x', 'o' }, ';', rep.repeat_last_move_next, { desc = 'TS: repeat last move next' })

    -- Optional: make f/F/t/T repeatable too (expr mappings)
    map({ 'n', 'x', 'o' }, 'f', rep.builtin_f_expr, { expr = true, desc = 'TS: repeatable f' })
    map({ 'n', 'x', 'o' }, 'F', rep.builtin_F_expr, { expr = true, desc = 'TS: repeatable F' })
    map({ 'n', 'x', 'o' }, 't', rep.builtin_t_expr, { expr = true, desc = 'TS: repeatable t' })
    map({ 'n', 'x', 'o' }, 'T', rep.builtin_T_expr, { expr = true, desc = 'TS: repeatable T' })
end

return M
