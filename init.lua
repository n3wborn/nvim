vim.g.mapleader = ','
vim.g.maplocalleader = ','

_G.global = {}
_G.global.float_border_opts = { border = 'rounded', focusable = false, scope = 'line' }
vim.g.fff = {
    prompt = '🪿 ',

    layout = {
        height = 0.9,
        width = 0.9,
        prompt_position = 'top',
        preview_size = 0.6,
    },
    preview = {
        enabled = true,
        line_numbers = true,
    },
    debug = {
        enabled = false,
        show_scores = false,
    },
    grep = {
        max_matches_per_file = 1, -- 0 to unlimited
        time_budget_ms = 100, -- prevents UI freeze, 0 = no limit
    },
    keymaps = {
        close = '<esc><esc>',
        select = '<CR>',
        select_split = '<C-s>',
        select_vsplit = '<C-v>',
        select_tab = '<C-t>',
        -- you can assign multiple keys to any action
        move_up = { '<Up>', '<C-p>' },
        move_down = { '<Down>', '<C-n>' },
        preview_scroll_up = '<C-u>',
        preview_scroll_down = '<C-d>',
        toggle_debug = '<F2>',
        -- grep mode: cycle between plain text, regex, and fuzzy search
        cycle_grep_modes = '<S-Tab>',
        -- goes to the previous query in history
        cycle_previous_query = '<C-Up>',
        -- multi-select keymaps for quickfix
        toggle_select = '<Tab>',
        send_to_quickfix = '<C-q>',
        -- this are specific for the normal mode (you can exit it using any other keybind like jj)
        focus_list = '<leader>l',
        focus_preview = '<leader>p',
    },
    file_picker = {
        current_file_label = '[Current File]',
    },
}
local disabled_builtins = {
    'gzip',
    'matchit',
    'matchparen',
    'netrwPlugin',
    'tarPlugin',
    'tohtml',
    'tutor',
    'zipPlugin',
}

for _, plugin in ipairs(disabled_builtins) do
    vim.g['loaded_' .. plugin] = 1
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'plugins' },
        ---@type LazyPluginSpec
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'b0o/SchemaStore.nvim',
            },
            event = { 'BufReadPre', 'BufNewFile' },
        },
        ---@type LazyPluginSpec
        {
            'kylechui/nvim-surround',
            event = 'VeryLazy',
        },
        ---@type LazyPluginSpec
        {

            'nvzone/typr',
            dependencies = 'nvzone/volt',
            opts = {},
            cmd = { 'Typr', 'TyprStats' },
        },
        {
            'dmtrKovalenko/fff.nvim',
            lazy = false,
            build = function()
                require('fff.download').download_or_build_binary()
            end,
        },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    install = {
        missing = true,
        colorscheme = { 'catppuccin' },
    },
    checker = { enabled = true },
    rocks = { enabled = false },
})

vim.cmd.colorscheme('catppuccin-mocha')

vim.cmd('packadd nvim.difftool')
vim.cmd('packadd nvim.undotree')

require('config')
