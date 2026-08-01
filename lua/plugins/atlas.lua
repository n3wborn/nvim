---@type LazyPluginSpec
return {
    'emrearmagan/atlas.nvim',
    dependencies = {
        'sindrets/diffview.nvim',
    },
    cmd = {
        'AtlasIssue',
        'AtlasPull',
        'AtlasDiff',
        'AtlasNotes',
        'AtlasCreatePR',
        'AtlasCreateIssue',
        'AtlasSearch',
        'AtlasOpen',
        'AtlasClearCache',
        'AtlasLogs',
    },
    opts = {},
}
