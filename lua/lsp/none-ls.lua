-- null-ls
local null_ls = require('null-ls')
local b = null_ls.builtins

local sources = {
    --- code actions
    --- @todo: does not seem to work withh none-ls
    require('typescript.extensions.null-ls.code-actions'),

    --- diagnostics
    --- @todo: remove these when available with mfussenegger/nvim-lint
    b.diagnostics.gitlint,
    b.diagnostics.php,
    b.diagnostics.todo_comments,
    b.diagnostics.tsc,
}

local M = {
    setup = function(on_attach, capabilities)
        require('null-ls').setup({
            sources = sources,
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}

return M
