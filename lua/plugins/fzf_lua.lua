return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    keys = {
        { '<space>F', '<cmd>FzfLua<cr>', desc = 'open FzfLua' },
        -- {
        --     '<leader>fa',
        --     function()
        --         require('fzf-lua').files({
        --             cwd_prompt = false,
        --             cwd = '~/projects/qk-safety-lcsb/plugins/',
        --             prompt = 'Action Files❯ ',
        --             rg_ops = [[--files --hidden --follow -g "!.git" -t php ]],
        --         })
        --     end,
        --     desc = 'open FzfLua',
        -- },
    },
    opts = function()
        local actions = require('fzf-lua.actions')
        return {
            winopts = {
                preview = { default = 'bat_native' },
            },
            files = {
                fzf_opts = {
                    ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-files-history',
                },
            },
            grep = {
                cmd = "rg --color=always --smart-case -g '!{.git,node_modules,vendor,.cache,var}/'",
                fzf_opts = {
                    ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-grep-history',
                },
            },
            actions = {
                files = {
                    -- instead of the default action 'actions.file_edit_or_qf'
                    -- it's important to define all other actions here as this
                    -- table does not get merged with the global defaults
                    ['default'] = actions.file_edit_or_qf,
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-t'] = actions.file_tabedit,
                    ['alt-q'] = actions.file_sel_to_qf,
                    ['alt-l'] = actions.file_sel_to_ll,
                },
                buffers = {
                    -- providers that inherit these actions:
                    --   buffers, tabs, lines, blines
                    ['default'] = actions.buf_edit,
                    ['ctrl-x'] = actions.buf_split,
                    ['ctrl-v'] = actions.buf_vsplit,
                    ['ctrl-t'] = actions.buf_tabedit,
                },
            },
        }
    end,
    config = function(_, opts)
        -- calling `setup` is optional for customization
        require('fzf-lua').setup(opts)
    end,
}
