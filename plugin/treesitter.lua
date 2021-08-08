--- https://github.com/nvim-treesitter/nvim-treesitter

require('nvim-treesitter.configs').setup({
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
    },
    playground = {
        enable = false,
    },
    indent = {
        enable = true,
    },
    textobjects = {
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
    autopairs = {
        enable = true, -- check for autopairs (see nvim-autopairs)
    },
    -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
    refactor = {
        highlight_definitions = {
            enable = true,
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = 'R',
            },
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = 'gnd',
                list_definitions = 'gnD',
                list_definitions_toc = 'gO',
                goto_next_usage = '<a-*>',
                goto_previous_usage = '<a-µ>',
            },
        },
    },
})

--[[
-- Solidity hack
--
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1168
--]]

require('nvim-treesitter.parsers').get_parser_configs().Solidity = {
    install_info = {
        url = 'https://github.com/JoranHonig/tree-sitter-solidity',
        files = { 'src/parser.c' },
        requires_generate_from_grammar = true,
    },
    filetype = 'solidity',
}
