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

vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    command = 'checktime',
    desc = 'Check if we need to reload the file when it changed',
})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    group = vim.api.nvim_create_augroup('yank_highlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', priority = 250 }) --higher priority than lsp refs
    end,
    desc = 'Highlight on yank',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = {
        'PlenaryTestPopup',
        'help',
        'lspinfo',
        'man',
        'notify',
        'qf',
        'spectre_panel',
        'startuptime',
        'tsplayground',
        'trouble',
        'Navbuddy',
    },
    callback = function()
        vim.cmd([[
    nnoremap <silent> <buffer> q <cmd>close<CR>
    set nobuflisted
    ]])
    end,
    desc = 'Close some filetypes with <q>',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'gitcommit' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.linebreak = true
        vim.b.editorconfig = false
    end,
    desc = 'Set gitcommit config',
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = {
        'docker-compose.yml',
        'docker-compose.yaml',
        'compose.yml',
        'compose.yaml',
        -- stylua: ignore
        'compose.*.yaml',
        'compose.*.yml',
    },
    command = 'set filetype=yaml.docker-compose',
})

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local capabilities = client.server_capabilities

        -- diagnostics
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float)

        --- quickfix
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)

        -- show definition of current symbol
        if capabilities.definitionProvider then
            if client == 'typescript-tools' then
                vim.keymap.set('n', '<leader>gd', '<cmd>TSToolsGoToSourceDefinition<cr>', { buffer = args.buf })
            else
                vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { buffer = args.buf })
            end
        end

        -- show declaration of current symbol
        if capabilities.declarationProvider then
            vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { buffer = args.buf })
        end

        -- show definition of current type
        if capabilities.typeDefinitionProvider then
            vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, { buffer = args.buf })
        end

        -- rename current symbol
        if capabilities.renameProvider then
            vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { buffer = args.buf })
        end

        -- show code actions available
        if capabilities.codeActionProvider then
            vim.keymap.set('n', '<leader>ca', function()
                require('fzf-lua').lsp_code_actions({
                    winopts = {
                        relative = 'cursor',
                        width = 0.6,
                        height = 0.6,
                        row = 1,
                        preview = { vertical = 'up:70%' },
                    },
                })
            end, { buffer = args.buf })
        end

        -- show signature help
        if capabilities.signatureHelpProvider then
            vim.keymap.set('n', '<C-x><C-x>', vim.lsp.buf.signature_help, { buffer = args.buf })
        end
    end,
})

local conceal_ns = vim.api.nvim_create_namespace('class_conceal')
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
    desc = 'Conceal HTML class attributes. Ideal for big TailwindCSS class lists',
    group = vim.api.nvim_create_augroup('class_conceal', { clear = true }),
    pattern = { '*.tsx' },
    callback = function(event)
        local bufnr = event.buf or vim.api.nvim_get_current_buf()

        ---Ref: https://gist.github.com/mactep/430449fd4f6365474bfa15df5c02d27b
        local language_tree = vim.treesitter.get_parser(bufnr, 'tsx')
        local syntax_tree = language_tree:parse()
        local root = syntax_tree[1]:root()

        local ok, query = pcall(
            vim.treesitter.query.parse,
            'tsx',
            [[
    ((jsx_attribute
        (property_identifier) @att_name (#eq? @att_name "class")
        (string (string_fragment) @class_value)))
    ]]
        )
        if not ok then
            return
        end

        for _, captures, metadata in query:iter_matches(root, bufnr, root:start(), root:end_(), {}) do
            local start_row, start_col, end_row, end_col = captures[2]:range()
            vim.api.nvim_buf_set_extmark(bufnr, conceal_ns, start_row, start_col + 3, {
                end_line = end_row,
                end_col = end_col,
                conceal = '%', -- "…",
            })
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Enable inlay hints',
    callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = id and vim.lsp.get_client_by_id(id)
        if client == nil or not client.supports_method('textDocument/inlayHint') then
            return
        end

        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(0))
    end,
})

local resession = require('resession')

vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        require('resession').save('last')
    end,
})

vim.keymap.set('n', '<space>Ss', resession.save)
vim.keymap.set('n', '<space>Sl', resession.load)
vim.keymap.set('n', '<space>Sd', resession.delete)

-- session per git branch
-- (https://github.com/stevearc/resession.nvim/blob/492a2d6455ce7be3da3901402fd31a8dffb7f133/README.md#create-one-session-per-git-branch)
local get_session_name = function()
    local name = vim.fn.getcwd()
    local branch = vim.trim(vim.fn.system('git branch --show-current'))
    if vim.v.shell_error == 0 then
        return name .. branch
    else
        return name
    end
end

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        -- Only load the session if nvim was started with no args
        if vim.fn.argc(-1) == 0 then
            resession.load(get_session_name(), { dir = 'dirsession', silence_errors = true })
        end
    end,
})
vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        resession.save(get_session_name(), { dir = 'dirsession', notify = false })
    end,
})

vim.opt.updatetime = 400
