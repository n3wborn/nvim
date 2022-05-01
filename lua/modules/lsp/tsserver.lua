local u = require('utils')

local ts_utils_settings = {
    import_all_scan_buffers = 100,
    update_imports_on_move = true,
    filter_out_diagnostics_by_code = { 80001 },
}

local M = {}

M.setup = function(on_attach, capabilities)
    require('typescript').setup({
        server = {
            on_attach = function(client, bufnr)
                u.buf_map(bufnr, 'n', 'gs', ':TypescriptRemoveUnused<CR>')
                u.buf_map(bufnr, 'n', 'gS', ':TypescriptOrganizeImports<CR>')
                u.buf_map(bufnr, 'n', 'go', ':TypescriptAddMissingImports<CR>')
                u.buf_map(bufnr, 'n', 'gA', ':TypescriptFixAll<CR>')
                u.buf_map(bufnr, 'n', 'gI', ':TypescriptRenameFile<CR>')

                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
        },
    })
end

return M
