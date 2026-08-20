-- lua/config/folding.lua

local M = {}

local function has_ts_parser(bufnr)
    local ok = pcall(vim.treesitter.get_parser, bufnr)
    return ok
end

function M.setup(bufnr)
    bufnr = bufnr or 0

    local win = vim.wo

    if has_ts_parser(bufnr) then
        win.foldmethod = 'expr'
        win.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.opt_local.foldtext = ''
        return
    end

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client:supports_method('textDocument/foldingRange') then
            win.foldmethod = 'expr'
            win.foldexpr = 'v:lua.vim.lsp.foldexpr()'
            return
        end
    end

    win.foldmethod = 'indent'
    win.foldexpr = '0'
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        M.setup(args.buf)
    end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
    callback = function(args)
        M.setup(args.buf)
    end,
})

return M
