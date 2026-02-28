---@type LazyPluginSpec
return {
    'Punity122333/hexinspector.nvim',
    cmd = { 'HexEdit', 'HexInspect' },
    keys = {
        {
            '<leader>x',
            function()
                require('hexinspector').open()
            end,
            desc = 'Hex Editor',
        },
        {
            '<leader>X',
            function()
                vim.ui.input({ prompt = 'File path: ', default = vim.fn.expand('%:p') }, function(input)
                    if input and input ~= '' then
                        require('hexinspector').open(input)
                    end
                end)
            end,
            desc = 'Hex Editor (Pick File)',
        },
    },
    opts = {
        -- All options are optional. Shown below are the defaults.
        -- bytes_per_line = 24,
        -- max_undo = 200,
        -- max_memory_file = 64 * 1024 * 1024,
        -- colors = {
        --   bg           = "#1a1b26",
        --   info_bg      = "#1a1b26",
        --   border       = "#115e72",
        --   addr         = "#565f89",
        --   hex          = "#c0caf5",
        --   ascii        = "#9ece6a",
        --   null         = "#3b4261",
        --   cursor_bg    = "#28344a",
        --   cursor_line_bg = "#1e2030",
        --   float        = "#ff9e64",
        --   int          = "#bb9af7",
        --   uint         = "#7dcfff",
        --   title        = "#7aa2f7",
        --   search       = "#f7768e",
        --   modified     = "#f7768e",
        --   selection_bg = "#2d4f67",
        -- },
    },
}
