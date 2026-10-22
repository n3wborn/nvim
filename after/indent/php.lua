-- runtime indent/php.vim relies on legacy syntax (disabled by treesitter) and returns -1
vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
