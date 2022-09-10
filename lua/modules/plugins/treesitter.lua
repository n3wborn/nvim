--- https://github.com/nvim-treesitter/nvim-treesitter
local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if not treesitter_ok then
    print('Something went wrong with', treesitter)
    return
else
    treesitter.setup({
        ensure_installed = 'all',
        highlight = {
            enable = true,
        },
        indent = {
            enable = false,
        },
        textobjects = {
            lookahead = true,
            lsp_interop = {
                enable = true,
                border = 'rounded',
                peek_definition_code = {
                    ['df'] = '@function.outer',
                    ['dF'] = '@class.outer',
                },
            },
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
        },
        autopairs = { enable = true },
    })
end
