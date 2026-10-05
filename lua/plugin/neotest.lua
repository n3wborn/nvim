local add_on_file_type = require('vim-pack').add_on_file_type

-- Was never loaded with lazy.nvim (no trigger), now loaded with the only adapter's filetype.
add_on_file_type('php', {
    { src = 'nvim-lua/plenary.nvim', setup = false },
    { src = 'nvim-neotest/nvim-nio', setup = false },
    { src = 'olimorris/neotest-phpunit', setup = false },
    {
        src = 'nvim-neotest/neotest',
        opts = {
            adapters = {
                ['neotest-phpunit'] = {
                    root_ignore_files = { 'tests/Pest.php' },
                },
            },
        },
    },
})
