local diagnostic_icons = require('config.icons').diagnostics

---@type vim.diagnostic.Opts
vim.diagnostic.config({
    status = {
        format = function(counts)
            local items = {}
            for severity, count in pairs(counts) do
                local name = vim.diagnostic.severity[severity]
                local hl = 'DiagnosticSign' .. name:sub(1, 1) .. name:sub(2):lower()
                table.insert(items, ('%%#%s#%s %d'):format(hl, diagnostic_icons[name], count))
            end
            return table.concat(items, ' ')
        end,
    },

    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
            [vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
            [vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
            [vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
        },
    },
    severity_sort = true,
    underline = false,
    update_in_insert = true,
    -- TODO: choose which one is better
    -- update_in_insert = false,
    float = {
        source = 'if_many',
        -- Show severity icons as prefixes.
        prefix = function(diag)
            local level = vim.diagnostic.severity[diag.severity]
            local prefix = string.format(' %s ', diagnostic_icons[level])
            return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
        end,
    },
    jump = { on_jump = vim.diagnostic.open_float },
    -- TODO: choose lines or text
    virtual_lines = {
        current_line = true,
        severity = {
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.ERROR,
        },
    },
    -- virtual_text = {
    --     current_line = true,
    --     severity = {
    --         vim.diagnostic.severity.WARN,
    --         vim.diagnostic.severity.ERROR,
    --     },
    -- },
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp.keymaps', { clear = true }),
    desc = 'LSP Keymaps',
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local bufnr = ev.buf

        if client:supports_method('textDocument/documentSymbol') then
            vim.keymap.set({ 'n', 'x' }, '<leader>ss', function()
                require('fzf-lua').lsp_document_symbols()
            end, { desc = 'List Symbols' })
            vim.keymap.set(
                { 'n', 'x' },
                '<leader>sS',
                '<cmd>FzfLua lsp_live_workspace_symbols<cr>',
                { desc = 'List Workspace Symbols' }
            )
        end

        if client:supports_method('textDocument/definition') then
            vim.keymap.set({ 'n' }, 'gd', function()
                require('fzf-lua').lsp_definitions({ jump1 = true })
            end, { desc = 'Go to Definition' })
            vim.keymap.set({ 'n' }, 'gD', function()
                require('fzf-lua').lsp_definitions({ jump1 = false })
            end, { desc = 'Peek Definition' })
        end

        if client:supports_method('textDocument/references') then
            vim.keymap.set({ 'n' }, 'grr', '<cmd>FzfLua lsp_references<cr>')
        end

        if client:supports_method('textDocument/onTypeFormatting') then
            vim.lsp.on_type_formatting.enable(true, { bufnr = bufnr })
        end

        if client:supports_method('textDocument/documentColor') then
            vim.keymap.set({ 'n', 'x' }, 'grc', function()
                vim.lsp.document_color.color_presentation()
            end, { desc = 'Document Color Presentation' })
        end

        if client:supports_method('textDocument/inlayHint') and vim.g.lsp_inlay_hints then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if client:supports_method('textDocument/signatureHelp') then
            vim.keymap.set('i', '<C-k>', function()
                -- Close the completion menu first (if open).
                if require('blink.cmp.completion.windows.menu').win:is_open() then
                    require('blink.cmp').hide()
                end

                vim.lsp.buf.signature_help()
            end, { desc = 'Signature Help' })
        end

        if client:supports_method('textDocument/documentHighlight') then
            local under_cursor_highlights_group =
                vim.api.nvim_create_augroup('my.lsp.cursor_highlights', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
                group = under_cursor_highlights_group,
                desc = 'Highlight references under the cursor',
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
                group = under_cursor_highlights_group,
                desc = 'Clear highlight references',
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function()
        local servers = {
            'bashls',
            'gopls',
            'jsonls',
            -- emmylua_ls',
            'lua_ls',
            'kotlin_lsp',
            'marksman',
            'mpls',
            'oxfmt',
            -- 'intelephense',
            'phpantom',
            'tsgo',
            'taplo',
            'twiggy-language-server',
            'v_analyzer',
            'zls',
        }

        for _, server in ipairs(servers) do
            vim.lsp.enable(server)
        end
        vim.lsp.enable(servers)
    end,
})
