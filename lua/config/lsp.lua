local lua_ls_root_markers1 = {
    '.emmyrc.json',
    '.luarc.json',
    '.luarc.jsonc',
}
local lua_ls_root_markers2 = {
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
}

---@type vim.lsp.Config
vim.lsp.config('*', {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.uv.cwd()
        local root = vim.fs.root(fname, { '.git' })

        on_dir(root and vim.fs.relpath(cwd or {}, root) and cwd)
    end,
    root_markers = { '.git' },
})

---@type vim.lsp.Config
vim.lsp.config('intelephense', {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    init_options = {
        licenceKey = vim.env.INTELEPHENSE_LICENSE_KEY,
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 20 * 1024 * 1024, -- 20Mo
                associations = { '*.php', '*.phtml' },
            },
        },
    },
    root_markers = { '.git', 'composer.json' },
})
vim.lsp.enable('intelephense')

---@type vim.lsp.Config
vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    on_attach = function(client)
        -- disable formatting in favor of `stylua`
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
        Lua = {
            completion = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                globals = { 'vim', 'Snacks' }, -- when working on nvim plugins that lack a `.luarc.json`
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            hint = {
                enable = true,
                setType = true,
                arrayIndex = 'Disable', -- too noisy
                semicolon = 'Disable', -- mostly wrong on invalid code
            },
            telemetry = {
                enable = false,
            },
        },
    },
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { lua_ls_root_markers1, lua_ls_root_markers2, { '.git' } }
        or vim.list_extend(vim.list_extend(lua_ls_root_markers1, lua_ls_root_markers2), { '.git' }),
})
vim.lsp.enable('lua_ls')

---@type vim.lsp.Config
vim.lsp.config('emmylua_ls', {
    cmd = { 'emmylua_ls' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.emmyrc.json', '.luacheckrc', '.git' },
    workspace_required = false,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            runtime = {
                version = 'LuaJIT',
                requirePattern = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                    '?/lua/?.lua',
                    '?/lua/?/init.lua',
                },
            },
            workspace = {
                library = {
                    '$VIMRUNTIME',
                    '$HOME/.local/share/nvim/lazy',
                },
                ignoreGlobs = { '**/*_spec.lua' },
            },
        },
    },
})
-- vim.lsp.enable("emmylua_ls")

---@type vim.lsp.Config
vim.lsp.config('bashls', {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'bash', 'sh' },
    root_markers = { '.git' },
    settings = {
        bashIde = {
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
        },
    },
})
vim.lsp.enable('bashls')

---@type vim.lsp.Config
vim.lsp.config('twiggy-language-server', {
    -- npm i -g twiggy-language-server
    cmd = { 'twiggy-language-server', '--stdio' },
    filetypes = { 'twig' },
    root_markers = { 'composer.json', '.git' },
})
vim.lsp.enable('twiggy-language-server')

---@type vim.lsp.Config
vim.lsp.config('zls', {
    -- prebuilt binary https://zigtools.org/zls/releases/
    cmd = { 'zls' },
    filetypes = { 'zig' },
    root_markers = { 'build.zig' },
    -- There are two ways to set config options:
    --   - edit your `zls.json` that applies to any editor that uses ZLS
    --   - set in-editor config options with the `settings` field below.
    --
    -- Further information on how to configure ZLS:
    -- https://zigtools.org/zls/configure/
    settings = {
        zls = {
            -- Whether to enable build-on-save diagnostics
            --
            -- Further information about build-on save:
            -- https://zigtools.org/zls/guides/build-on-save/
            -- enable_build_on_save = true,

            -- omit the following line if `zig` is in your PATH
            zig_exe_path = '~/bin/zig-v0.15.1',
        },
    },
})
vim.lsp.enable('zls')

---@type vim.lsp.Config
vim.lsp.config('gopls', {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.mod', 'go.sum' },
})
vim.lsp.enable('gopls')

---@type vim.lsp.Config
vim.lsp.config('v_analyzer', {
    cmd = { '/home/stef/bin/v-analyzer' },
    filetypes = { 'v', 'vlang' },
    root_markers = { 'v.mod', '.git' },
    settings = {
        ['v-analyzer'] = {
            diagnostics = {
                enable = true,
            },
            completion = {
                enable = true,
            },
            hover = {
                enable = true,
            },
        },
    },
})
vim.lsp.enable('v_analyzer')

---@type vim.lsp.Config
vim.lsp.config('tsgo', {
    cmd = { 'tsgo', '--lsp', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
    root_dir = function(bufnr, on_dir)
        local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
        root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
            or vim.list_extend(root_markers, { '.git' })
        local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

        on_dir(project_root)
    end,
})
vim.lsp.enable('tsgo')

---@type vim.lsp.Config
vim.lsp.config('marksman', {
    cmd = { 'marksman', 'server' },
    filetypes = { 'markdown', 'markdown.mdx' },
    root_markers = { '.marksman.toml', '.git' },
})
vim.lsp.enable('marksman')

---@type vim.lsp.Config
vim.lsp.config('jsonls', {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    settings = {
        json = {
            validate = { enable = true },
            schemas = require('schemastore').json.schemas(),
        },
    },
    init_options = {
        provideFormatter = false,
    },
})
vim.lsp.enable('jsonls')

local signs = require('config.icons').diagnostics

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
        },
    },

    severity_sort = true,
    underline = false,
    update_in_insert = true,
    float = true,
    jump = { on_jump = vim.diagnostic.open_float },
})
