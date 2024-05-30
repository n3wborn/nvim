return {
    'echasnovski/mini.animate',
    version = false,
    config = function()
        require('mini.animate').setup(
            -- No need to copy this inside `setup()`. Will be used automatically.
            {
                -- Cursor path
                cursor = {
                    -- Whether to enable this animation
                    enable = true,
                },

                -- Vertical scroll
                scroll = {
                    -- Whether to enable this animation
                    enable = true,
                },

                -- Window resize
                resize = {
                    -- Whether to enable this animation
                    enable = true,
                },

                -- Window open
                open = {
                    -- Whether to enable this animation
                    enable = true,
                },

                -- Window close
                close = {
                    -- Whether to enable this animation
                    enable = true,
                },
            }
        )
    end,
}
