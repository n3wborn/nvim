local api = vim.api
local lsp = vim.lsp

local keymaps = require('config.lsp.keymaps')
local capabilities = require('config.lsp.capabilities')

api.nvim_create_autocmd('LspAttach', {
    group = api.nvim_create_augroup('my.lsp.attach', {}),

    callback = function(ev)
        local client = assert(lsp.get_client_by_id(ev.data.client_id))

        keymaps.apply({
            client = client,
            bufnr = ev.buf,

            highlight_group = api.nvim_create_augroup('my.lsp.highlight-' .. ev.buf, {}),
        }, capabilities)
    end,
})
