return {
    'nvim-neotest/neotest',
    dependencies = {
        'olimorris/neotest-phpunit',
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {
        adapters = {
            ['neotest-phpunit'] = {
                root_ignore_files = { 'tests/Pest.php' },
            },
        },
    },
}
