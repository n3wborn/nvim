-- null-ls
local null_ls = require('null-ls')
local b = null_ls.builtins
local ts_code_actions = require('typescript.extensions.null-ls.code-actions')

local with_root_file = function(builtin, file)
    return builtin.with({
        condition = function(utils)
            return utils.root_has_file(file)
        end,
    })
end

local sources = {
    --- code actions
    b.code_actions.eslint,
    b.code_actions.gitrebase,
    b.code_actions.refactoring,
    b.code_actions.shellcheck,
    ts_code_actions,

    --- diagnostics
    b.diagnostics.gitlint,
    b.diagnostics.markdownlint,
    b.diagnostics.php,
    b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
    b.diagnostics.todo_comments,
    b.diagnostics.trail_space,
    b.diagnostics.tsc,
    b.diagnostics.zsh,

    --- formatting
    b.formatting.blade_formatter,
    b.formatting.eslint_d,
    b.formatting.fixjson,
    b.formatting.goimports,
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
    b.formatting.prettier.with({
        disabled_filetypes = { 'typescript', 'typescriptreact', 'markdown' },
    }),
    b.formatting.rustfmt,
    b.formatting.shfmt,
    b.formatting.sqlformat,
    with_root_file(b.formatting.stylua, 'stylua.toml'),
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
