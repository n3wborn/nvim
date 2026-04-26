---@type LazyPluginSpec
return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = {
        'arborist-ts/arborist.nvim',
    },
    init = function()
        vim.g.no_plugin_maps = true
    end,
    keys = function()
        local modes = { 'n', 'x', 'o' }

        local function move(method, query, group)
            return function()
                require('nvim-treesitter-textobjects.move')[method](query, group)
            end
        end

        local maps = {
            -- next start
            { ']m', 'goto_next_start', '@function.outer', 'textobjects' },
            { ']]', 'goto_next_start', '@class.outer', 'textobjects' },
            { ']o', 'goto_next_start', { '@loop.inner', '@loop.outer' }, 'textobjects' },
            { ']s', 'goto_next_start', '@local.scope', 'locals' },
            { ']z', 'goto_next_start', '@fold', 'folds' },

            -- next end
            { ']M', 'goto_next_end', '@function.outer', 'textobjects' },
            { '][', 'goto_next_end', '@class.outer', 'textobjects' },

            -- previous start
            { '[m', 'goto_previous_start', '@function.outer', 'textobjects' },
            { '[[', 'goto_previous_start', '@class.outer', 'textobjects' },

            -- previous end
            { '[M', 'goto_previous_end', '@function.outer', 'textobjects' },
            { '[]', 'goto_previous_end', '@class.outer', 'textobjects' },

            -- conditional
            { ']d', 'goto_next', '@conditional.outer', 'textobjects' },
            { '[d', 'goto_previous', '@conditional.outer', 'textobjects' },
        }

        local keys = {}
        for _, m in ipairs(maps) do
            table.insert(keys, {
                m[1],
                move(m[2], m[3], m[4]),
                mode = modes,
            })
        end

        return keys
    end,

    config = function()
        require('config.treesitter_textobjects_keymaps').setup()
    end,
}
