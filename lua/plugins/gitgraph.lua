---@type LazyPluginSpec
return {
    'isakbm/gitgraph.nvim',
    opts = {
        git_cmd = 'git',
        symbols = {
            merge_commit = '',
            commit = '',
            merge_commit_end = '',
            commit_end = '',

            -- Advanced symbols
            GVER = '',
            GHOR = '',
            GCLD = '',
            GCRD = '╭',
            GCLU = '',
            GCRU = '',
            GLRU = '',
            GLRD = '',
            GLUD = '',
            GRUD = '',
            GFORKU = '',
            GFORKD = '',
            GRUDCD = '',
            GRUDCU = '',
            GLUDCD = '',
            GLUDCU = '',
            GLRDCL = '',
            GLRDCR = '',
            GLRUCL = '',
            GLRUCR = '',
        },
        format = {
            timestamp = '%H:%M:%S %d-%m-%Y',
            fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
        },
        hooks = {
            on_select_commit = function(commit)
                print('selected commit:', commit.hash)
            end,
            on_select_range_commit = function(from, to)
                print('selected range:', from.hash, to.hash)
            end,
        },
    },
    keys = {
        {
            '<space>gl',
            function()
                require('gitgraph').draw({}, { all = true, max_count = 5000 })
            end,
            desc = 'GitGraph - Draw',
        },
    },
}
