local opts = {
    move = {
        enable = true,
        set_jumps = true,
    },
    swap = {
        enable = true,
    },
    select = {
        enable = true,
        lookahead = true,
    },
}

require('nvim-treesitter-textobjects').setup(opts)

local move = require('nvim-treesitter-textobjects.move')
local swap = require('nvim-treesitter-textobjects.swap')
local select = require('nvim-treesitter-textobjects.select')
local keymaps = {
    {
        { 'n', 'x', 'o' },
        '[f',
        function()
            move.goto_previous_start('@function.outer', 'textobjects')
        end,
        { desc = 'prev function' },
    },
    {
        { 'n', 'x', 'o' },
        ']f',
        function()
            move.goto_next_start('@function.outer', 'textobjects')
        end,
        { desc = 'next function' },
    },
    {
        { 'n', 'x', 'o' },
        '[F',
        function()
            move.goto_previous_end('@function.outer', 'textobjects')
        end,
        { desc = 'prev function end' },
    },
    {
        { 'n', 'x', 'o' },
        ']F',
        function()
            move.goto_next_end('@function.outer', 'textobjects')
        end,
        { desc = 'next function end' },
    },
    {
        { 'n', 'x', 'o' },
        '[p',
        function()
            move.goto_previous_start('@parameter.outer', 'textobjects')
        end,
        { desc = 'prev argument' },
    },
    {
        { 'n', 'x', 'o' },
        ']p',
        function()
            move.goto_next_start('@parameter.outer', 'textobjects')
        end,
        { desc = 'next argument' },
    },
    {
        { 'n', 'x', 'o' },
        '[P',
        function()
            move.goto_previous_end('@parameter.outer', 'textobjects')
        end,
        { desc = 'prev argument end' },
    },
    {
        { 'n', 'x', 'o' },
        ']P',
        function()
            move.goto_next_end('@parameter.outer', 'textobjects')
        end,
        { desc = 'next argument end' },
    },
    {
        { 'n', 'x', 'o' },
        '[s',
        function()
            move.goto_previous_start('@block.outer', 'textobjects')
        end,
        { desc = 'prev block' },
    },
    {
        { 'n', 'x', 'o' },
        ']s',
        function()
            move.goto_next_start('@block.outer', 'textobjects')
        end,
        { desc = 'next block' },
    },
    {
        { 'n', 'x', 'o' },
        '[S',
        function()
            move.goto_previous_end('@block.outer', 'textobjects')
        end,
        { desc = 'prev block' },
    },
    {
        { 'n', 'x', 'o' },
        ']S',
        function()
            move.goto_next_end('@block.outer', 'textobjects')
        end,
        { desc = 'next block' },
    },
    {
        { 'n', 'x', 'o' },
        'gan',
        function()
            swap.swap_next('@parameter.inner')
        end,
        { desc = 'swap next argument' },
    },
    {
        { 'n', 'x', 'o' },
        'gap',
        function()
            swap.swap_previous('@parameter.inner')
        end,
        { desc = 'swap prev argument' },
    },
    {
        { 'n', 'x', 'o' },
        'vif',
        function()
            select.select_textobject('@function.inner', 'textobjects')
        end,
        { desc = 'select inside function' },
    },
    {
        { 'n', 'x', 'o' },
        'vaf',
        function()
            select.select_textobject('@function.outer', 'textobjects')
        end,
        { desc = 'select around function' },
    },
    {
        { 'n', 'x', 'o' },
        'vib',
        function()
            select.select_textobject('@block.inner', 'textobjects')
        end,
        { desc = 'select inside block' },
    },
    {
        { 'n', 'x', 'o' },
        'vab',
        function()
            select.select_textobject('@block.outer', 'textobjects')
        end,
        { desc = 'select around block' },
    },
    {
        { 'n', 'x', 'o' },
        'vic',
        function()
            select.select_textobject('@conditional.inner', 'textobjects')
        end,
        { desc = 'select inside condition' },
    },
    {
        { 'n', 'x', 'o' },
        'vac',
        function()
            select.select_textobject('@conditional.outer', 'textobjects')
        end,
        { desc = 'select around condition' },
    },
}

for _, map in ipairs(keymaps) do
    vim.keymap.set(unpack(map))
end
