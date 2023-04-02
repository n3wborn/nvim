local u = require('utils')

local M = {
    setup = function(on_attach, capabilities)
        require('typescript').setup({
            server = {
                on_attach = function(client, bufnr)
                    u.buf_map(bufnr, 'n', '<space>F', ':TypescriptFixAll<CR>')
                    u.buf_map(bufnr, 'n', '<space>I', ':TypescriptAddMissingImports<CR>')
                    u.buf_map(bufnr, 'n', '<space>O', ':TypescriptOrganizeImports<CR>')
                    u.buf_map(bufnr, 'n', '<space>R', ':TypescriptRenameFile<CR>')
                    on_attach(client, bufnr)
                end,
                capabilities = capabilities,
            },
        })
    end,
}

return M
