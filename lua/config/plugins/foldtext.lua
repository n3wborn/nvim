return {
    src = 'https://github.com/OXY2DEV/foldtext.nvim',
    data = {
        setup = function()
            local opts = {
                ignore_filetypes = {},
                ignore_buftypes = {},

                styles = {
                    default = {
                        { kind = 'indent' },
                        { kind = 'description' },
                        {
                            kind = 'fold_size',
                            condition = function(_, _, parts)
                                return #parts > 1
                            end,

                            padding_left = ' ',
                            icon = '󰘖 ',

                            hl = '@conditional',
                        },
                        {
                            kind = 'fold_size',
                            condition = function(_, _, parts)
                                return #parts == 1
                            end,

                            icon = '󰘖 ',
                            padding_right = ' lines folded!',

                            padding_right_hl = '@comment',
                            icon_hl = '@conditional',
                            hl = '@number',
                        },
                    },

                    ts_expr = {
                        condition = function(_, window)
                            return vim.wo[window].foldmethod == 'expr'
                                and vim.wo[window].foldexpr == 'v:lua.vim.treesitter.foldexpr()'
                        end,
                        parts = {
                            {
                                kind = 'bufline',

                                delimiter = ' ... ',
                                hl = '@comment',
                            },
                        },
                    },
                },
            }

            require('foldtext').setup(opts)
        end,
    },
}
