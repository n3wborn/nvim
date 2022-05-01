-- null-ls
local null_ls = require('null-ls')
local b = null_ls.builtins

local with_root_file = function(builtin, file)
    return builtin.with({
        condition = function(utils)
            return utils.root_has_file(file)
        end,
    })
end

-- null-ls sources
local sources = {
    ---actions
    b.code_actions.gitsigns,
    b.code_actions.gitrebase,
    ---formatting
    b.formatting.prettier.with({
        disabled_filetypes = { 'typescript', 'typescriptreact' },
    }),
    with_root_file(b.formatting.stylua, 'stylua.toml'),
    b.formatting.trim_whitespace,
    b.formatting.phpcsfixer.with({
        filetypes = { 'php' },
        command = 'php-cs-fixer',
        args = { '--no-interaction', '--quiet', '--rules=@PSR12,@Symfony', 'fix', '$FILENAME' },
    }),
    b.formatting.shfmt,
    b.formatting.fixjson,
    b.formatting.sqlformat,
    b.formatting.rustfmt,
    b.formatting.goimports,
    ---diagnostics
    b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
    b.diagnostics.tsc,
    b.diagnostics.php,
    b.diagnostics.gitlint,
    b.diagnostics.zsh,
    b.diagnostics.trail_space,
}

local M = {
    setup = function(on_attach, capabilities)
        require('null-ls').setup({
            sources = sources,
            on_attach = on_attach,
        })
    end,
}

return M
