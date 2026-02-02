local aug = vim.api.nvim_create_augroup('my.config', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
    group = aug,
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
    desc = 'Do not auto comment on new line',
})

vim.api.nvim_create_autocmd('FileType', {
    group = aug,
    callback = function(ctx)
        if vim.bo[ctx.buf].buftype ~= '' then
            return
        end
        vim.cmd([[silent! normal! g`"]])
    end,
    desc = 'Restore cursor position',
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'TermClose', 'TermLeave' }, {
    group = aug,
    callback = function(ev)
        if vim.fn.getcmdwintype() ~= '' then
            return
        end

        if ev.event == 'FocusGained' or ev.event == 'TermClose' or ev.event == 'TermLeave' then
            vim.cmd('checktime')
            return
        end

        local bo = vim.bo[ev.buf]
        if bo.buftype == '' and not bo.modified and vim.api.nvim_buf_get_name(ev.buf) ~= '' then
            vim.cmd('checktime ' .. ev.buf)
        end
    end,
    desc = 'Auto reload files changed on disk',
})

vim.api.nvim_create_autocmd('VimResized', {
    group = aug,
    callback = function()
        vim.cmd.wincmd('=')
    end,
    desc = 'Keep splits equally sized',
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
    group = aug,
    callback = vim.schedule_wrap(function()
        vim.cmd.nohlsearch()
    end),
    desc = 'Remove search highlight',
})

vim.api.nvim_create_autocmd('FileType', {
    group = aug,
    pattern = {
        'gitsigns-blame',
        'git',
        'checkhealth',
        'help',
        'lspinfo',
        'man',
        'Navbuddy',
        'notify',
        'oil',
        'PlenaryTestPopup',
        'qf',
        'spectre_panel',
        'startuptime',
        'quickfix',
        'lazy',
    },
    callback = function(event)
        local bufnr = event.buf
        vim.bo[bufnr].buflisted = false

        vim.keymap.set('n', 'q', '<cmd>close<CR>', {
            buffer = bufnr,
            silent = true,
            desc = 'Close window',
        })
    end,
    desc = 'Configure special buffers',
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
    group = aug,
    callback = function()
        vim.opt_local.cursorline = true
    end,
    desc = 'Enable cursorline in active window',
})

vim.api.nvim_create_autocmd('WinLeave', {
    group = aug,
    callback = function()
        if vim.bo.buftype ~= 'quickfix' then
            vim.opt_local.cursorline = false
        end
    end,
    desc = 'Disable cursorline when leaving window',
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = aug,
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged', 'BufLeave', 'FocusLost' }, {
    group = aug,
    callback = function(ctx)
        local saveInstantly = ctx.event == 'FocusLost' or ctx.event == 'BufLeave'

        local bufnr = ctx.buf
        local bo, b = vim.bo[bufnr], vim.b[bufnr]
        local bufname = vim.api.nvim_buf_get_name(bufnr)

        if bo.buftype ~= '' or bo.ft == 'gitcommit' or bo.readonly then
            return
        end

        if b.saveQueued and not saveInstantly then
            return
        end

        b.saveQueued = true

        vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(bufnr) then
                return
            end

            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd(('silent! noautocmd lockmarks update! %q'):format(bufname))
            end)

            b.saveQueued = false
        end, saveInstantly and 0 or 2000)
    end,
    desc = 'Auto save',
})

vim.api.nvim_create_autocmd('FocusGained', {
    group = aug,
    callback = function()
        local closed = {}

        for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
            if not vim.api.nvim_buf_is_valid(buf.bufnr) then
                goto continue
            end

            local exists = vim.uv.fs_stat(buf.name)
            local special = vim.bo[buf.bufnr].buftype ~= ''
            local newbuf = buf.name == ''

            if exists or special or newbuf then
                goto continue
            end

            table.insert(closed, vim.fs.basename(buf.name))
            vim.api.nvim_buf_delete(buf.bufnr, { force = false })

            ::continue::
        end

        if #closed == 0 then
            return
        end

        vim.notify(table.concat(closed, '\n'), nil, {
            title = 'Buffers closed',
            icon = '󰅗',
        })

        vim.schedule(function()
            if vim.api.nvim_buf_get_name(0) ~= '' then
                return
            end

            for _, file in ipairs(vim.v.oldfiles) do
                if vim.uv.fs_stat(file) and vim.fs.basename(file) ~= 'COMMIT_EDITMSG' then
                    vim.cmd.edit(file)
                    return
                end
            end
        end)
    end,
    desc = 'Close non-existing buffers',
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
    desc = 'LSP keymaps & features',
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local bufnr = ev.buf

        local map = function(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- diagnostics
        map('n', '<leader>D', vim.diagnostic.open_float)

        -- completion
        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })

        -- navigation
        if client:supports_method('textDocument/definition') then
            map('n', 'gd', vim.lsp.buf.definition)
        end

        if client:supports_method('textDocument/declaration') then
            map('n', 'gD', vim.lsp.buf.declaration)
        end

        if client:supports_method('textDocument/typeDefinition') then
            map('n', '<leader>gt', vim.lsp.buf.type_definition)
        end

        if client:supports_method('textDocument/implementation') then
            map('n', 'gri', vim.lsp.buf.implementation)
        end

        if client:supports_method('callHierarchy/incomingCalls') then
            map('n', 'grI', vim.lsp.buf.incoming_calls)
        end

        -- editing
        if client:supports_method('textDocument/rename') then
            map('n', '<leader>R', vim.lsp.buf.rename)
        end

        if client:supports_method('textDocument/onTypeFormatting') then
            vim.lsp.on_type_formatting.enable()
        end

        map('i', '<M-s>', vim.lsp.buf.signature_help)

        -- UI extras
        -- if client:supports_method('textDocument/documentSymbol') then
        --     require('nvim-navic').attach(client, bufnr)
        -- end

        if client:supports_method('textDocument/documentColor') then
            vim.lsp.document_color.enable(true, bufnr)
        end

        if client:supports_method('textDocument/inlayHint') and vim.g.lsp_inlay_hints then
            vim.lsp.inlay_hint.enable(true)
        end

        if client:supports_method('textDocument/inlineCompletion') then
            vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
            map('i', '<C-F>', vim.lsp.inline_completion.get, { desc = 'Accept inline completion' })
            map('i', '<C-G>', vim.lsp.inline_completion.select, { desc = 'Cycle inline completion' })
        end
    end,
})

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach', 'DiagnosticChanged' }, {
    group = vim.api.nvim_create_augroup('StatuslineUpdate', { clear = true }),
    desc = 'Update statusline/winbar',
    callback = vim.schedule_wrap(function()
        vim.cmd.redrawstatus()
    end),
})
