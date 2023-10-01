-- null-ls
local null_ls = require('null-ls')
local b = null_ls.builtins

local sources = {
    --- code actions
    require('typescript.extensions.null-ls.code-actions'),

    --- diagnostics
    b.diagnostics.gitlint,
    b.diagnostics.php,
    b.diagnostics.todo_comments,
    b.diagnostics.tsc,
    b.diagnostics.zsh,

    --- formatting
    b.formatting.blade_formatter,
    b.formatting.fixjson,
    b.formatting.goimports,
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
