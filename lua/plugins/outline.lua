---@type LazyPluginSpec
return {
    'hedyhli/outline.nvim',
    keys = {
        { '<leader>o', ':Outline<CR>', { desc = 'Outline' } },
    },
    ---@module "outline"
    ---@type outline.SetupOpts
    opts = {
        outline_window = {
            center_on_jump = true,
            relative_width = true,
            show_cursorline = true,
        },
    },
}
