-- npm install typescript (v7.0+, native compiler with `--lsp` support)
-- Overrides nvim-lspconfig's `lsp/tsc.lua` (settings are inherited from it).
local bin_cache = {} ---@type table<string, string|false>

--- Checks if the given tsc/tsgo cmd supports the "--lsp" arg.
---@param bin string
---@return boolean
local function supports_lsp(bin)
    if vim.fn.executable(bin) ~= 1 then
        return false
    end

    local ok, out = pcall(function()
        return vim.system({ bin, '--version' }, { text = true }):wait(5000)
    end)
    local version = ok and out.code == 0 and vim.version.parse(out.stdout or '') or nil

    return version ~= nil and version.major >= 7
end

--- Returns the first tsc/tsgo binary supporting `--lsp`, local ones first.
---@param root string
---@return string|false
local function find_bin(root)
    for _, name in ipairs({ 'tsc', 'tsgo' }) do
        for _, bin in ipairs({ vim.fs.joinpath(root, 'node_modules/.bin', name), name }) do
            if supports_lsp(bin) then
                return bin
            end
        end
    end

    return false
end

---@type vim.lsp.Config
return {
    cmd = function(dispatchers, config)
        config = config or {}

        return vim.lsp.rpc.start({ bin_cache[config.root_dir] or 'tsc', '--lsp', '--stdio' }, dispatchers, {
            cwd = config.cmd_cwd or config.root_dir,
            env = config.cmd_env,
            detached = config.detached,
        })
    end,
    root_dir = function(bufnr, on_dir)
        -- `tsc` supports monorepos natively (it finds the tsconfig.json/jsconfig.json closest to
        -- the edited file), so we only need the workspace root: the closest package manager
        -- lockfile, then `.git`. Lockfiles take precedence, so git submodules share the parent instance.
        local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
        root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
            or vim.list_extend(root_markers, { '.git' })

        -- Deno projects use denols instead: bail out if a Deno marker is closer than (or as
        -- close as) the package manager lockfile.
        local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
        local deno_lock_root = vim.fs.root(bufnr, { 'deno.lock' })
        local project_root = vim.fs.root(bufnr, root_markers)

        if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
            return
        end

        if deno_root and (not project_root or #deno_root >= #project_root) then
            return
        end

        -- Outside of any project, use the file's directory rather than the cwd (which may be
        -- $HOME and make the server crawl it).
        local root = project_root or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))

        if bin_cache[root] == nil then
            bin_cache[root] = find_bin(root)

            if not bin_cache[root] then
                vim.notify(
                    ('tsc: no binary supporting `--lsp` found for %s (requires TypeScript 7.0+)'):format(root),
                    vim.log.levels.WARN
                )
            end
        end

        if bin_cache[root] then
            on_dir(root)
        end
    end,
}
