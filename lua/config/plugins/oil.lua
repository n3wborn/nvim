return {
    src = 'https://github.com/stevearc/oil.nvim',
    data = {
        setup = function()
            require('oil').setup({
                skip_confirm_for_simple_edits = true,
                prompt_save_on_select_new_entry = false,
                lsp_file_methods = {
                    autosave_changes = true,
                },
                columns = { 'icon' },
                keymaps = {
                    ['<C-h>'] = false,
                    ['<M-h>'] = 'actions.select_split',
                },
                view_options = {
                    show_hidden = true,
                },
            })

            -- stylua: ignore
            vim.keymap.set('n', '-', function() require('oil').open() end)
        end,
    },
}
