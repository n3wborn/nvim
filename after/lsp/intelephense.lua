local function filter_propel_type_errors(diagnostics)
    return vim.tbl_filter(function(diagnostic)
        if diagnostic.code == 'P1006' then
            local message = diagnostic.message
            if message:match("Expected type 'object'%. Found 'int'") then
                -- ensure we are in a Propel context
                local uri = diagnostic.source and diagnostic.source.uri or ''
                if uri:match('Propel') or uri:match('generated') then
                    return false
                end
            end
        end
        return true
    end, diagnostics)
end

---@type vim.lsp.Config
return {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_markers = { '.git', 'composer.json' },
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    handlers = {
        ['textDocument/publishDiagnostics'] = filter_propel_type_errors,
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 20 * 1024 * 1024, -- 20Mo
                associations = { '*.php', '*.phtml' },
            },
        },
    },
}
