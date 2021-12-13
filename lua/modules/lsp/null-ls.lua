-- null-ls
local null_ls = require('null-ls')
local b = null_ls.builtins

-- null-ls sources
local sources = {
    ---actions
    b.code_actions.gitsigns,
    b.code_actions.gitrebase,
    ---formatting
    b.formatting.prettier.with({
        disabled_filetypes = { 'typescript', 'typescriptreact' },
    }),
    b.formatting.stylua.with({
        condition = function(utils)
            return utils.root_has_file('stylua.toml')
        end,
    }),
    b.formatting.trim_whitespace,
    b.formatting.phpcsfixer.with({
        filetypes = { 'php' },
        command = 'php-cs-fixer',
        args = { '--no-interaction', '--quiet', '--rules=@PSR12,@Symfony', 'fix', '$FILENAME' },
    }),
    b.formatting.shfmt,
    b.formatting.fixjson,
    b.formatting.json_tool,
    b.formatting.sqlformat,
    b.formatting.rustfmt,
    ---diagnostics
    b.diagnostics.shellcheck,
    b.diagnostics.write_good,
    b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
    b.diagnostics.tsc,
    b.diagnostics.php,
}

local M = {
    setup = function(on_attach, capabilities)
        require('null-ls').setup({
            sources = sources,
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
}

return M
