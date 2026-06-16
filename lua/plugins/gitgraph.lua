---@type LazyPluginSpec
return {
    'isakbm/gitgraph.nvim',
    dependencies = {
        'dlyongemallo/diffview-plus.nvim',
    },
    ---@module "gitgraph"
    ---@type I.GGConfig
    ---@diagnostic disable-next-line: missing-fields
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
            -- Check diff of a commit
            on_select_commit = function(commit)
                vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
                vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
            end,
            -- Check diff from commit a -> commit b
            on_select_range_commit = function(from, to)
                vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
                vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
            end,
        },
    },
    keys = {
        {
            '<space>gl',
            function()
                vim.cmd('tabnew')
                require('gitgraph').draw({}, { all = true, max_count = 5000 })
            end,
            desc = 'GitGraph - Draw',
        },
    },
}
