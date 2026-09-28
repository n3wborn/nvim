-- lua/config/folding.lua

local M = {}

local function has_ts_parser(bufnr)
    -- Since nvim 0.12, get_parser() returns nil instead of throwing
    return vim.treesitter.get_parser(bufnr, nil, { error = false }) ~= nil
end

---@param bufnr integer
---@param opts table<string, string>
local function set_local(bufnr, opts)
    -- Apply to every window displaying the buffer, like :setlocal
    for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
        for name, value in pairs(opts) do
            vim.wo[win][0][name] = value
        end
    end
end

function M.setup(bufnr)
    if bufnr == nil or bufnr == 0 then
        bufnr = vim.api.nvim_get_current_buf()
    end

    if has_ts_parser(bufnr) then
        set_local(bufnr, {
            foldmethod = 'expr',
            foldexpr = 'v:lua.vim.treesitter.foldexpr()',
            foldtext = '',
        })
        return
    end

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client:supports_method('textDocument/foldingRange') then
            set_local(bufnr, {
                foldmethod = 'expr',
                foldexpr = 'v:lua.vim.lsp.foldexpr()',
            })
            return
        end
    end

    set_local(bufnr, {
        foldmethod = 'indent',
        foldexpr = '0',
    })
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
