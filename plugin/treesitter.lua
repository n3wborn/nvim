--- Treesitter

require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true -- false will disable the whole extension
	},
	playground = {
		enable = true
	},
	indent = {
		enable = true
	},
	textobjects = {
        lsp_interop = {
            enable = true
        },
		select = {
			enable = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
}

--[[
-- Solidity hack
--
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1168
--]]

require "nvim-treesitter.parsers".get_parser_configs().Solidity = {
    install_info = {
        url = "https://github.com/JoranHonig/tree-sitter-solidity",
        files = {"src/parser.c"},
        requires_generate_from_grammar = true,
    },
    filetype = 'solidity'
}
