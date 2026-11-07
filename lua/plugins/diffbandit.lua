---@type LazyPluginSpec
return {
    'CoreyKaylor/diffbandit.nvim',
    cmd = {
        'DiffBandit',
        'DiffBanditBuffers',
        'DiffBanditFolderDiff',
        'DiffBanditGit',
        'DiffBanditGitCurrent',
        'DiffBanditCommitPanel',
        'DiffBanditGitMenu',
        'DiffBanditGitLog',
        'DiffBanditGitCommit',
        'DiffBanditGitCompare',
        'DiffBanditGitCheckout',
        'DiffBanditMerge',
    },
    keys = {
        {
            '<leader>g',
            '<cmd>DiffBanditGit<cr>',
            desc = 'DiffBandit Git Menu',
        },
    },
    opts = {},
}
