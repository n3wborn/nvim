-- https://github.com/nvim-telescope/telescope.nvim
local u = require('utils')

require('telescope').setup({
    defaults = {
        prompt_prefix = '❯ ',
        selection_caret = '❯ ',
        sorting_strategy = 'ascending',
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
            },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--ignore',
            '--hidden',
            '-g',
            '!.git',
        },
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
})

-- generic mappings
u.map('n', '<Leader>T', ':Telescope<CR>')
u.map('n', '<Leader>t', ':Telescope treesitter<CR>')

--find * commands/mappings
u.command('Files', 'Telescope find_files')
u.command('Rg', 'Telescope live_grep')
u.command('GrepStr', 'Telescope grep_string')
u.command('BLines', 'Telescope current_buffer_fuzzy_find')
u.command('History', 'Telescope oldfiles')
u.command('Buffers', 'Telescope buffers')

u.map('n', '<Leader>f', '<cmd>Files<CR>')
u.map('n', '<Leader>sp', '<cmd>Rg<CR>')
u.map('n', '<Leader>sd', '<cmd>GrepStr<CR>')
u.map('n', '<Leader>b', '<cmd>Buffers<CR>')
u.map('n', '<Leader>o', '<cmd>History<CR>')

--git * commands
u.command('BCommits', 'Telescope git_bcommits')
u.command('Commits', 'Telescope git_commits')
u.command('Branchs', 'Telescope git_branches')
u.command('GStatus', 'Telescope git_status')

u.map('n', '<Leader>gc', '<cmd>Commits<CR>')
u.map('n', '<Leader>gp', '<cmd>BCommits<CR>')
u.map('n', '<Leader>gb', '<cmd>Branchs<CR>')
u.map('n', '<Leader>gs', '<cmd>GStatus<CR>')

--help commands
u.command('HelpTags', 'Telescope help_tags')
u.command('ManPages', 'Telescope man_pages')

u.map('n', '<Leader>H', ':HelpTags<CR>')
u.map('n', '<leader>m', ':ManPages<CR>')

-- lsp mappings/commands
u.map('n', '<Leader>ls', '<cmd>LspSym<CR>')
u.command('LspRef', 'Telescope lsp_references')
u.command('LspDef', 'Telescope lsp_definitions')
u.command('LspSym', 'Telescope lsp_workspace_symbols')

-- functions/classes
u.command('GrepFuncs', ':lua require("telescope.builtin").live_grep({default_text="function"})<CR>')
u.command('GrepClasses', ':lua require("telescope.builtin").live_grep({default_text="class"})<CR>')

u.map('n', '<space>f', '<cmd>GrepFuncs<CR>')
u.map('n', '<space>c', '<cmd>GrepClasses<CR>')

-- extensions mappings/commands
require('telescope').load_extension('project')
require('telescope').load_extension('lazygit')
require('telescope').load_extension('gh')
require('telescope').load_extension('ui-select')

u.command('Project', 'Telescope project')
u.map('n', '<C-p>', '<cmd>Project<CR>')

u.command('Lazygit', 'Telescope lazygit')
u.map('n', '<space>G', '<cmd>Lazygit<CR>')

u.command('GithubIssues', 'Telescope gh issues')
u.map('n', '<space>gi', '<cmd>GithubIssues<CR>')

u.command('GithubPr', 'Telescope gh pull_request')
u.map('n', '<space>gp', '<cmd>GithubPr<CR>')

u.command('GithubGist', 'Telescope gh gist')
u.map('n', '<space>gg', '<cmd>GithubGist<CR>')

u.command('GithubRun', 'Telescope gh run')
u.map('n', '<space>gr', '<cmd>GithubRun<CR>')
