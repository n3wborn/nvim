vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    callback = function()
        vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
    end,
    desc = 'Do not auto comment on new line',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'json', 'jsonc' },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
    desc = 'Fix conceallevel for json an help files',
})

vim.api.nvim_create_autocmd('FileType', {
    desc = 'User: Restore cursor position',
    callback = function(ctx)
        if vim.bo[ctx.buf].buftype ~= '' then
            return
        end
        vim.cmd([[silent! normal! g`"]])
    end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    command = 'checktime',
    desc = 'Check if we need to reload the file when it changed',
})

vim.api.nvim_create_autocmd('VimResized', {
    desc = 'User: keep splits equally sized on window resize',
    command = 'wincmd =',
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
    callback = vim.schedule_wrap(function()
        vim.cmd.nohlsearch()
    end),
    desc = 'Remove hl search when enter Insert',
})

vim.api.nvim_create_autocmd('FileType', {
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
        local ft = vim.bo[bufnr].filetype
        vim.bo[bufnr].buflisted = false

        vim.keymap.set('n', 'q', '<cmd>close<CR>', {
            buffer = bufnr,
            silent = true,
            desc = 'Close window',
        })
    end,
    desc = 'Configure special buffers to close with q (and ESC for lazy)',
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

        -- diagnostics
        vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float)

        -- completion
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end

        if client:supports_method('callHierarchy/incomingCalls') then
            vim.keymap.set('n', 'grI', vim.lsp.buf.incoming_calls, { buffer = ev.buf })
        end

        -- default keymaps
        -- grn = vim.lsp.buf.rename()
        -- gra = vim.lsp.buf.code_action()
        -- grr = vim.lsp.buf.references()
        -- gri = vim.lsp.buf.implementation()
        -- g0 = vim.lsp.buf.document_symbol()
        -- C_S = (insert)  vim.lsp.buf.signature_help()

        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf })
        end

        if client:supports_method('textDocument/declaration') then
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf })
        end

        if client:supports_method('textDocument/typeDefinition') then
            vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, { buffer = ev.buf })
        end

        if client:supports_method('textDocument/implementation') then
            vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { buffer = ev.buf })
        end

        if client:supports_method('textDocument/rename') then
            vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { buffer = ev.buf })
        end

        if client:supports_method('textDocument/rangesFormatting') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        if client:supports_method('textDocument/onTypeFormatting') then
            vim.lsp.on_type_formatting.enable()
        end

        if client:supports_method('textDocument/documentSymbol') then
            local navic = require('nvim-navic')
            navic.attach(client, ev.buf)

            vim.keymap.set('n', 'g0', vim.lsp.buf.rename, { buffer = ev.buf })
        end

        if client:supports_method('textDocument/documentColor') then
            vim.lsp.document_color.enable(true, ev.buf)
        end

        if client:supports_method('textDocument/colorPresentation') then
            vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled(ev.buf), ev.buf)
        end

        if client:supports_method('textDocument/inlayHint') and vim.g.lsp_inlay_hints then
            vim.lsp.inlay_hint.enable(true)
        end

        if
            client:supports_method('textDocument/inlineCompletion')
            and (vim.g.copilot_enabled or vim.g.cursor_enabled)
        then
            vim.lsp.inline_completion.enable(true)
        end

        vim.keymap.set('i', '<M-s>', vim.lsp.buf.signature_help, { buffer = ev.buf })
        vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float)
    end,
})

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach', 'DiagnosticChanged' }, {
    group = vim.api.nvim_create_augroup('StatuslineUpdate', { clear = true }),
    pattern = '*',
    callback = vim.schedule_wrap(function()
        vim.cmd('redrawstatus')
    end),
    desc = 'Update statusline/winbar',
})

vim.api.nvim_create_autocmd('FocusGained', {
    desc = 'User: Close all non-existing buffers on `FocusGained`.',
    callback = function()
        local closedBuffers = {}
        local allBufs = vim.fn.getbufinfo({ buflisted = 1 })
        vim.iter(allBufs):each(function(buf)
            if not vim.api.nvim_buf_is_valid(buf.bufnr) then
                return
            end
            local stillExists = vim.uv.fs_stat(buf.name) ~= nil
            local specialBuffer = vim.bo[buf.bufnr].buftype ~= ''
            local newBuffer = buf.name == ''
            if stillExists or specialBuffer or newBuffer then
                return
            end
            table.insert(closedBuffers, vim.fs.basename(buf.name))
            vim.api.nvim_buf_delete(buf.bufnr, { force = false })
        end)
        if #closedBuffers == 0 then
            return
        end

        if #closedBuffers == 1 then
            vim.notify(closedBuffers[1], nil, { title = 'Buffer closed', icon = '󰅗' })
        else
            local text = '- ' .. table.concat(closedBuffers, '\n- ')
            vim.notify(text, nil, { title = 'Buffers closed', icon = '󰅗' })
        end

        -- If ending up in empty buffer, re-open the first oldfile that exists
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
})

-- https://github.com/chrisgrieser/.config/blob/main/nvim/lua/config/autocmds.lua#L84
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged', 'BufLeave', 'FocusLost' }, {
    desc = 'User: Auto-save',
    callback = function(ctx)
        local saveInstantly = ctx.event == 'FocusLost' or ctx.event == 'BufLeave'
        local bufnr = ctx.buf
        local bo, b = vim.bo[bufnr], vim.b[bufnr]
        local bufname = ctx.file
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
                -- saving with explicit name prevents issues when changing `cwd`
                -- `:update!` suppresses "The file has been changed since reading it!!!"
                local vimCmd = ('silent! noautocmd lockmarks update! %q'):format(bufname)
                vim.cmd(vimCmd)
            end)
            b.saveQueued = false
        end, saveInstantly and 0 or 2000)
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = vim.api.nvim_create_augroup('my.yankHighlight', { clear = true }),
    pattern = '*',
})

local aug = vim.api.nvim_create_augroup('my.config', {})

vim.api.nvim_create_autocmd('FocusGained', {
    desc = 'Reload files from disk when we focus vim',
    pattern = '*',
    command = "if getcmdwintype() == '' | checktime | endif",
    group = aug,
})
vim.api.nvim_create_autocmd('BufEnter', {
    desc = 'Every time we enter an unmodified buffer, check if it changed on disk',
    pattern = '*',
    command = "if &buftype == '' && !&modified && expand('%') != '' | exec 'checktime ' . expand('<abuf>') | endif",
    group = aug,
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
    desc = 'Highlight the cursor line in the active window',
    pattern = '*',
    command = 'setlocal cursorline',
    group = aug,
})
vim.api.nvim_create_autocmd('WinLeave', {
    desc = 'Clear the cursor line highlight when leaving a window',
    pattern = '*',
    command = "if &bt != 'quickfix' | setlocal nocursorline | endif",
    group = aug,
})

vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('my.config.session', { clear = true }),
    callback = function()
        if vim.fn.argc() == 0 then
            local persistence = require('persistence')
            persistence.load()
        end
    end,
    nested = true,
})
