--"nanotee inspired" lsp config
-- (https://github.com/nanotee/dotfiles/blob/master/.config/nvim/lua/my/config/lsp.lua)

local M = {}
local map = vim.api.nvim_set_keymap

local float_border = 'single'
local show_line_diagnostics = vim.lsp.diagnostic.show_line_diagnostics


map('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true})
map('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true})
map('n', '<leader>d', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true})
map('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true})


vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
    }
)

vim.lsp.diagnostic.show_line_diagnostics = function(opts, ...)
    opts = opts or {}
    opts.border = float_border
    show_line_diagnostics(opts, ...)
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = float_border,
    }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = float_border,
    }
)


-- Custom attach
local function custom_attach(client, bufnr)

    if client.name == 'sqls' then
        client.resolved_capabilities.execute_command = true
        require('sqls').setup{
            picker = 'fzf',
        }
    end

    local function bmap(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, {noremap = true})
    end

    local cap = client.resolved_capabilities

    if cap.goto_definition then
        bmap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    end

    if cap.hover then
        bmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
    end

    if cap.signature_help then
        bmap('n', 'gS', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
    end

    if cap.code_action then
        bmap('n', 'gA', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
        bmap('x', 'gA', '<Esc><Cmd>lua vim.lsp.buf.range_code_action()<CR>')
    end

    if cap.rename then
        bmap('n', '<leader>rn', 'vim.lsp.buf.rename()<CR>')
    end
end

-- init
function M.init()
    local lsp = require('lspconfig')
    local servers = {
        lsp.tsserver,
        lsp.pyright,
        lsp.sqls,
    }

    -- custom_attach listed servers
    for _, server in ipairs(servers) do
        server.setup {
            on_attach = custom_attach,
        }
    end

    -- custom_attach + special settings
    lsp.jsonls.setup {
        cmd = {'vscode-json-language-server', '--stdio'},
        on_attach = custom_attach,
    }

    lsp.html.setup {
        cmd = {'vscode-html-language-server', '--stdio'},
        on_attach = custom_attach,
    }

    lsp.cssls.setup {
        cmd = {'vscode-css-language-server', '--stdio'},
        on_attach = custom_attach,
    }

    lsp.intelephense.setup {
        autostart = true,
        on_attach = custom_attach,
    }

end


return M
