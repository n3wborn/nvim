--[[ LSP config ]]

local nvim_lsp = require('lspconfig')

-- on_attach
local on_attach = function(_client, bufnr)
    -- Omnifunc
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Signature
    require('lsp_signature').on_attach()

    -- Kind
    require('lspkind').init({
        with_text = true,
        symbol_map = {
            Text = ' ',
            Method = ' ',
            Function = ' ',
            Ctor = ' ',
            Field = ' ',
            Variable = ' ',
            Class = ' ',
            Interface = 'ﰮ ',
            Module = ' ',
            Property = ' ',
            Unit = 'ﰩ ',
            Value = ' ',
            Enum = '練',
            Keyword = ' ',
            Snippet = '﬌ ',
            Color = ' ',
            File = ' ',
            Reference = ' ',
            Folder = ' ',
            EnumMember = ' ',
            Constant = 'ﱃ ',
            Struct = ' ',
            Event = ' ',
            Operator = '璉',
            TypeParameter = ' ',
        },
    })

    -- Diagnostics
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        signs = true,
        virtual_text = false,
    })

    -- Hover
    local hover = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/hover'] = function(...)
        local buf = hover(...)
        vim.api.nvim_buf_set_keymap(buf, 'n', 'K', '<Cmd>wincmd p<CR>', { noremap = true, silent = true })
    end

    -- Mappings
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>A', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '[d',
        '<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = { border = "rounded"}})<CR>',
        opts
    )

    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        ']d',
        '<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = { border = "rounded"}})<CR>',
        opts
    )

    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<leader>D',
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({popup_opts = { border = "rounded"}})<CR>',
        opts
    )

    vim.api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<leader>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
        opts
    )
end

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Servers
local servers = {
    'intelephense',
    'cssls',
    'yamlls',
    'jsonls',
    'rust_analyzer',
}

-- Servers setup
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

--[[ Null-ls ]]
local null_ls = require('null-ls')
local b = null_ls.builtins

-- sources
local sources = {
    -- builtins : https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    -- formatting
    b.formatting.prettierd.with({
        filetypes = { 'html', 'json', 'yaml', 'markdown' },
    }),
    b.formatting.stylua.with({
        condition = function(utils)
            return utils.root_has_file('stylua.toml')
        end,
    }),
    b.formatting.phpcbf,
    b.formatting.trim_whitespace.with({ filetypes = { 'tmux', 'teal', 'zsh' } }),
    b.formatting.shfmt,
    -- diagnostics
    b.diagnostics.shellcheck,
    b.diagnostics.write_good,
    b.diagnostics.markdownlint,
    b.diagnostics.shellcheck,
    b.code_actions.gitsigns,
}

-- setup
require('null-ls').config({
    sources = sources,
})

require('lspconfig')['null-ls'].setup({
    on_attach = on_attach,
})

--[[ Tsserver ]]
require('modules.lsp.tsserver')
