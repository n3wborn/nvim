return {
    src = 'https://github.com/akinsho/git-conflict.nvim',
    data = {
        setup = function()
            require('git-conflict').setup({
                default_mappings = true, -- disable buffer local mapping created by this plugin
                default_commands = true, -- disable commands created by this plugin
                disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
                list_opener = 'copen', -- command or function to open the conflicts list
                highlights = { -- They must have background color, otherwise the default color will be used
                    incoming = 'DiffAdd',
                    current = 'DiffText',
                },
            })
        end,
    },
}
