local add = require('vim-pack').add

add({
    {
        src = 'hedyhli/outline.nvim',
        ---@module "outline"
        ---@type outline.SetupOpts
        opts = {
            outline_window = {
                center_on_jump = true,
                relative_width = true,
                show_cursorline = true,
            },
        },
        on_setup = function()
            vim.keymap.set('n', '<leader>o', ':Outline<CR>', { desc = 'Outline' })
        end,
    },
})
