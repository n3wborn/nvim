-- lsp

local lsp = vim.lsp
local cmd = vim.api.nvim_command

-- handlers config
lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
    lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = false,
        update_in_insert = true,
    }
)

lsp.handlers["textDocument/hover"] =
    lsp.with(
        lsp.handlers.hover,
        {
            border = "single"
        }
    )

lsp.handlers["textDocument/signatureHelp"] =
    lsp.with(
        lsp.handlers.signature_help,
        {
            border = "single"
        }
    )

-- attach
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- attach lspkind
    require('lspkind').init(
        {
            with_text = true,
            symbol_map = {
                Folder = ""
            }
        }
    )

    -- attach lsp_signature
    require('lsp_signature').on_attach()

    -- Mappings (commented one are handled by Telescope and lspsaga)
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap('n', '<leader>S', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>P', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<M-Enter>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=Purple
            hi LspReferenceText cterm=bold ctermbg=red guibg=Purple
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=Purple
        ]], false)
        cmd 'autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()'
        cmd 'autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()'
        cmd 'autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()'
    end
end


local function setup_servers()
    require'lspinstall'.setup()
    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do
        require'lspconfig'[server].setup{on_attach = on_attach}
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
    setup_servers() -- reload installed servers
    cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
