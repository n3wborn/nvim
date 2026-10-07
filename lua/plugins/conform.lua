-- oxfmt: executed in the compose `node` service when it is running (its node_modules
-- may hold container-only native bindings, e.g. musl), otherwise on the host.
local oxfmt_container = { service = 'node', workdir = '/app', ttl_ms = 30000 }
local oxfmt_cache = { bins = {}, services = {} }

---@param bin string
---@return boolean
local function oxfmt_bin_works(bin)
    if oxfmt_cache.bins[bin] == nil then
        oxfmt_cache.bins[bin] = vim.fn.executable(bin) == 1 and vim.system({ bin, '--version' }):wait().code == 0
    end
    return oxfmt_cache.bins[bin]
end

---@param root string compose project directory
---@return boolean
local function oxfmt_service_running(root)
    local now = vim.uv.now()
    local cached = oxfmt_cache.services[root]
    if not cached or now - cached.at > oxfmt_container.ttl_ms then
        local res = vim.system(
            { 'docker', 'compose', 'ps', '--status', 'running', '--services' },
            { cwd = root, text = true }
        )
            :wait()
        local services = res.code == 0 and vim.split(res.stdout, '\n', { trimempty = true }) or {}
        cached = { at = now, running = vim.list_contains(services, oxfmt_container.service) }
        oxfmt_cache.services[root] = cached
    end
    return cached.running
end

---@param ctx conform.Context
---@return { command: string, args: string[] }
local function oxfmt_resolve(ctx)
    local local_bin = vim.fs.find('node_modules/.bin/oxfmt', { upward = true, path = ctx.dirname, type = 'file' })[1]
    local root =
        vim.fs.root(ctx.dirname, { 'compose.yaml', 'compose.yml', 'docker-compose.yaml', 'docker-compose.yml' })

    -- Passed explicitly: oxfmt does not always pick it up by itself (e.g. next to a vite.config.js).
    local config = vim.fs.find({ '.oxfmtrc.json', '.oxfmtrc.jsonc' }, { upward = true, path = ctx.dirname })[1]

    ---@param map fun(path: string): string
    local function oxfmt_args(map)
        local args = config and { '-c', map(config) } or {}
        return vim.list_extend(args, { '--stdin-filepath', map(ctx.filename) })
    end

    if local_bin and root and vim.fs.relpath(root, local_bin) and vim.fn.executable('docker') == 1 then
        if oxfmt_service_running(root) then
            local function in_container(path)
                return vim.fs.joinpath(oxfmt_container.workdir, vim.fs.relpath(root, path))
            end
            -- A config outside the mounted project cannot be seen from the container.
            if not config or vim.fs.relpath(root, config) then
                return {
                    command = 'docker',
                    args = vim.list_extend({
                        'compose',
                        '--project-directory',
                        root,
                        'exec',
                        '-T',
                        oxfmt_container.service,
                        in_container(local_bin),
                    }, oxfmt_args(in_container)),
                }
            end
        end
    end

    local function identity(path)
        return path
    end
    if local_bin and oxfmt_bin_works(local_bin) then
        return { command = local_bin, args = oxfmt_args(identity) }
    end
    if local_bin then
        vim.notify_once(
            'oxfmt: ' .. local_bin .. ' is not usable on the host, falling back to global oxfmt',
            vim.log.levels.WARN
        )
    end
    return { command = 'oxfmt', args = oxfmt_args(identity) }
end

---@type LazyPluginSpec
return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    --- @module "conform"
    --- @type nil|conform.setupOpts
    opts = {
        exclude_path_patterns = {
            '/node_modules/',
            '/vendor/',
        },
        formatters_by_ft = {
            go = { 'gofmt' },
            lua = { 'stylua' },
            markdown = { 'rumdl' },
            php = { 'php_cs_fixer' },
            python = {
                -- To fix auto-fixable lint errors.
                'ruff_fix',
                -- To run the Ruff formatter.
                'ruff_format',
                -- To organize the imports.
                'ruff_organize_imports',
            },
            rust = { 'rustfmt' },
            sh = { 'shfmt', 'shellcheck' },
            sql = { 'sql_formatter' },
            twig = { 'twig-cs-fixer' },
            v = { 'v' },

            -- https://oxc.rs/
            javascript = { 'oxfmt' },
            javascriptreact = { 'oxfmt' },
            typescript = { 'oxfmt' },
            typescriptreact = { 'oxfmt' },
            json = { 'oxfmt' },
            jsonc = { 'oxfmt' },
            vue = { 'oxfmt' },

            ['*'] = { 'trim_whitespace', 'squeeze_blanks', 'trim_newlines' },
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { async = false, timeout_ms = 2000, lsp_format = 'never' }
        end,
        formatters = {
            oxfmt = {
                command = function(_, ctx)
                    return oxfmt_resolve(ctx).command
                end,
                args = function(_, ctx)
                    return oxfmt_resolve(ctx).args
                end,
            },
            php_cs_fixer = {
                env = { PHP_CS_FIXER_IGNORE_ENV = 1 },
                args = function(_, ctx)
                    local args = { 'fix', '$FILENAME', '--quiet', '--no-interaction', '--using-cache=no' }
                    local found = nil
                    local core_dir = os.getenv('CORE_DIR')
                    local root_dir = nil

                    if core_dir then
                        root_dir = vim.fs.find(core_dir, { type = 'directory', upward = true, path = ctx.dirname })[1]
                        if root_dir then
                            found = vim.fs.find('.php-cs-fixer.php.dist', { path = root_dir, type = 'file' })[1]
                            vim.api.nvim_echo({ { 'Found corePlugin at:\n' }, { root_dir } }, true, {})
                        end
                    end

                    if not found then
                        found = vim.fs.find('.php-cs-fixer.php.dist', { upward = true, path = ctx.dirname })[1]
                        if found then
                            vim.api.nvim_echo({ { 'Using fallback php-cs-fixer config:\n' }, { found } }, true, {})
                        end
                    end

                    if found then
                        vim.list_extend(args, { '--config=' .. found })
                    else
                        vim.list_extend(args, { '--rules=@PSR12,@Symfony' })
                    end

                    return args
                end,
            },
        },
    },
}
