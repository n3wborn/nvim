vim.pack.add({
    {
        name = 'gitsigns',
        src = 'https://github.com/lewis6991/gitsigns.nvim',
    },
})

local gitsigns = require('gitsigns')

local opts = {
    signs = {
        add = { text = '│ ' },
        change = { text = '│ ' },
        delete = { text = '│ ' },
        topdelete = { text = '│ ' },
        changedelete = { text = '│ ' },
        untracked = { text = '│ ' },
    },
    signs_staged = {
        add = { text = '│ ' },
        change = { text = '│ ' },
        delete = { text = '│ ' },
        topdelete = { text = '│ ' },
        changedelete = { text = '│ ' },
    },
    current_line_blame = true,
    preview_config = {
        style = 'minimal',
    },
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align
        delay = 999,
        ignore_whitespace = false,
        virt_text_priority = 99,
    },
    gh = true,
    watch_gitdir = { enabled = true, follow_files = true },
    on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local nav_hunk_opts = { preview = true, greedy = false, target = 'all' }

        local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
        end

        map('n', '<leader>hn', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gs.nav_hunk('next', nav_hunk_opts)
            end
        end, 'Next Hunk')
        map('n', '<leader>hN', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gs.nav_hunk('prev', nav_hunk_opts)
            end
        end, 'Prev Hunk')
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', '󰊢 (Un)Stage Hunk')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', '󰊢 Reset Hunk')
        map('n', '<leader>hS', gs.stage_buffer, '󰊢 Stage Buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk, '󰊢 Undo Stage Hunk')
        map('n', '<leader>hR', gs.reset_buffer, '󰊢 Reset Buffer')
        map('n', '<leader>hp', gs.preview_hunk_inline, '󰊢 Preview Hunk Inline')
        map('n', '<leader>hb', function()
            gs.blame_line({ full = true })
        end, '󰊢 Blame Line')
        map('n', '<leader>hB', function()
            gs.blame()
        end, '󰊢 Blame Buffer')
        map('n', '<leader>tb', function()
            gs.toogle_current_line_blame()
        end, '󰊢 Toogle Current B')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', '󰊢 GitSigns Select Hunk')
    end,
}

gitsigns.setup(opts)
