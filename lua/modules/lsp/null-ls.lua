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
    b.code_actions.gitrebase,
    b.code_actions.eslint,
    b.code_actions.refactoring,
    b.code_actions.shellcheck,
    ---formatting
    b.formatting.eslint_d,
    b.formatting.prettier.with({
        disabled_filetypes = { 'typescript', 'typescriptreact' },
    }),
    with_root_file(b.formatting.stylua, 'stylua.toml'),
    b.formatting.phpcsfixer.with({
        filetypes = { 'php' },
        command = 'php-cs-fixer',
        args = {
            '--no-interaction',
            '--quiet',
            '--using-cache=' .. 'no',
            '--config=' .. '$ROOT' .. '/.php-cs-fixer.php',
            'fix',
            '$FILENAME',
        },
        condition = function(utils)
            return utils.root_has_file('.php-cs-fixer.php')
        end,
    }),
    b.formatting.phpcsfixer.with({
        filetypes = { 'php' },
        command = 'php-cs-fixer',
        args = {
            '--no-interaction',
            '--quiet',
            '--using-cache=' .. 'no',
            '--rules=' .. '@PSR12,@Symfony',
            'fix',
            '$FILENAME',
        },
        condition = function(utils)
            return not utils.root_has_file('.php-cs-fixer.php')
        end,
    }),
    b.formatting.shfmt,
    b.formatting.fixjson,
    b.formatting.sqlformat,
    b.formatting.rustfmt,
    b.formatting.goimports,
    b.formatting.blade_formatter,
    ---diagnostics
    b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
    b.diagnostics.tsc,
    b.diagnostics.php,
    b.diagnostics.gitlint,
    b.diagnostics.zsh,
    b.diagnostics.todo_comments,
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
