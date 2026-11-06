-- https://github.com/symfony/language-tools/blob/main/docs/configuration.rst
---@type vim.lsp.Config
return {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
    cmd = { 'symfony-lsp' },
    init_options = {
        consolePath = 'bin/console',
        containerProjectRoot = '',
        debug = true,
        environment = 'dev',
        phpCommand = { 'php' },
        projectRoots = {},
        runtimeIndexing = true,
        trace = 'off',
    },
    filetypes = { 'php', 'twig', 'yaml', 'json', 'xml', 'javascript', 'typescript', 'env' },
    root_markers = { '.git', 'composer.json' },
    settings = {
        symfonyLsp = {
            consolePath = 'bin/console',
            containerProjectRoot = '',
            debug = true,
            environment = 'dev',
            phpCommand = { 'php' },
            projectRoots = {},
            runtimeIndexing = true,
            translationDiagnostics = false,
        },
    },
    workspace_required = true,
}
