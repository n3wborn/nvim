vim.api.nvim_create_autocmd('FileType', {
    desc = 'Enable Treesitter',
    group = vim.api.nvim_create_augroup('my.aucmd.install_and_enable_treesitter_when_needed', {}),
    callback = function(event)
        local bufnr = event.buf
        local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })

        -- Skip if no filetype or bigfile
        if filetype == '' or vim.bo[bufnr].filetype ~= 'bigfile' then
            return
        end

        -- Get parser name based on filetype
        local parser_name = vim.treesitter.language.get_lang(filetype)
        if not parser_name then
            vim.notify(vim.inspect('No treesitter parser found for filetype: ' .. filetype), vim.log.levels.WARN)
            -- Use regex based syntax-highlighting as fallback
            vim.bo[bufnr].syntax = 'ON'
            return
        end

        -- Try to get existing parser
        local ts_config = require('nvim-treesitter.config')
        if not vim.tbl_contains(ts_config.get_available(), parser_name) then
            return
        end

        -- Start treesitter for this buffer
        local start_ts = function()
            vim.treesitter.start(bufnr, parser_name)
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldmethod = 'expr'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.cmd.normal('zx')
        end

        local already_installed = ts_config.get_installed('parsers')
        if not vim.tbl_contains(already_installed, parser_name) then
            -- Install parser
            vim.notify('Installing parser for ' .. parser_name, vim.log.levels.INFO)
            require('nvim-treesitter').install({ parser_name }):await(start_ts)
            return
        end

        start_ts()
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('my.aucmd.do_not_comment_on_new_line', { clear = true }),
    desc = 'Do not auto comment on new line',
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('my.aucmd.restore_last_location', { clear = true }),
    desc = 'Restore cursor position',
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('my.aucmd.close_with_q', { clear = true }),
    desc = 'Close with <q>',
    pattern = {
        'Navbuddy',
        'PlenaryTestPopup',
        'checkhealth',
        'git',
        'git',
        'gitsigns-blame',
        'help',
        'lazy',
        'lspinfo',
        'man',
        'notify',
        'oil',
        'qf',
        'quickfix',
        'spectre_panel',
        'startuptime',
    },
    callback = function(args)
        if args.match ~= 'help' or not vim.bo[args.buf].modifiable then
            vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
        end
    end,
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

        if client:supports_method('textDocument/documentColor') then
            vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled())
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

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        -- treesitter
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then
                vim.cmd.packadd('nvim-treesitter')
            end
            vim.cmd('TSUpdate')
        end

        -- fff
        if name == 'fff.nvim' and kind == 'update' then
            if not ev.data.active then
                vim.cmd.packadd('fff.nvim')
            end

            require('fff.download').download_or_build_binary()
        end
    end,
})

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        -- TODO: Check if process is ok !
    end,
})
