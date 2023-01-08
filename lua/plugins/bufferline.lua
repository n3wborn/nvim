return {
    {
        'akinsho/bufferline.nvim',
        config = function()
            require('bufferline').setup({
                options = {
                    mode = 'tabs',
                    show_close_icon = true,
                    diagnostics = 'nvim_lsp',
                    always_show_bufferline = false,
                    separator_style = 'default',
                    offsets = {
                        {
                            filetype = 'NvimTree',
                            text = 'NvimTree',
                            highlight = 'Directory',
                            text_align = 'center',
                            separator = true,
                        },
                    },
                },
            })
        end,
    },
}
