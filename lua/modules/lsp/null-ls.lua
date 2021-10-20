local null_ls = require('null-ls')
local b = null_ls.builtins

local sources = {
    b.code_actions.gitsigns,
    require('null-ls.helpers').conditional(function(utils)
        return utils.root_has_file('.eslintrc.js') and b.formatting.eslint_d or b.formatting.prettier
    end),
    --[[ b.formatting.prettierd.with({
        filetypes = { 'html', 'json', 'yaml' },
    }), ]]
    b.formatting.stylua.with({
        condition = function(utils)
            return utils.root_has_file('stylua.toml')
        end,
    }),
    b.formatting.trim_whitespace,
    b.formatting.phpcsfixer.with({
        filetypes = { 'php' },
        command = 'php-cs-fixer',
        -- maybe have to find a better way to choose between them
        -- args = { '--no-interaction', '--quiet', '--rules=@Symfony', 'fix', '$FILENAME' },
        -- args = { '--no-interaction', '--quiet', '--rules=@PSR12', 'fix', '$FILENAME' },
        args = { '--no-interaction', '--quiet', '--rules=@PSR12,@Symfony', 'fix', '$FILENAME' },
    }),
    -- b.formatting.phpcbf,
    b.formatting.shfmt,
    b.formatting.fixjson,
    b.formatting.json_tool,
    b.formatting.sqlformat,
    b.formatting.rustfmt,
    b.diagnostics.shellcheck,
    b.diagnostics.write_good,
    b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
    b.code_actions.gitsigns,
    b.diagnostics.phpcs.with({
        filetypes = { 'php' },
        command = 'phpcs',
        args = { '--report=json', '--standard=PSR12', '-s', '-' },
    }),
    --[[ b.diagnostics.phpstan.with({
        filetypes = { 'php' },
        command = 'phpstan',
        args = { 'analyze', '--error-format', 'json', '-l6', '--no-progress', '$FILENAME' },
    }), ]]
    b.diagnostics.yamllint,
}

local M = {}
M.setup = function(on_attach)
    null_ls.config({
        -- debug = true,
        sources = sources,
    })
    require('lspconfig')['null-ls'].setup({ on_attach = on_attach })
end

return M
