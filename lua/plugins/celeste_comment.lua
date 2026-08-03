---@type LazyPluginSpec
return {
    'celeste3z/celeste_comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    ---@type Celeste.Comment.Opts
    opts = {
        -- Restore cursor position after commenting.
        keep_cursor = true,

        -- Restore selection after commenting.
        -- See `:help celeste_comment-config-keep_selection`
        -- Possible values: "never" | "accurate" | "expand_block"
        keep_selection = 'never',

        -- Insert space between comment marker and text.
        insert_space = true,

        -- Place comment at start of line, skip indent alignment
        line_comment_no_indent = false,

        -- Match comment markers case-insensitively (e.g. `@REM` vs `@rem` vs `@rEm`)
        case_insensitive = false,

        -- Trim whitespace before detecting block tokens.
        block_relaxed_detect = true,

        -- Max lines to search for block comment pairs.
        block_textobj_nlines = 200,

        -- How to handle empty lines during comment toggle.
        -- See `:help celeste_comment-config-ignore_empty_lines` for more details
        -- Possible values: "never" | "mixed" | "always"
        ignore_empty_lines = 'mixed',

        -- Fallback to block comment when line comment wraps.
        -- See `:help celeste_comment-config-fallback_to_block` for more details
        -- Possible values: "never" | "if_line_cms_wrapped"
        fallback_to_block = 'if_line_cms_wrapped',

        -- Log level (nvim-0.13+). Ignored on older versions.
        log_level = vim.log.levels.OFF,

        -- Comment string configuration.
        cms_confs = nil,

        mappings = {
            -- Line comment by motion (n)
            line_toggle = 'gc',
            -- Line comment current line (n)
            line_toggle_cur = 'gcc',
            -- Line comment visual selection (x)
            line_toggle_visual = 'gc',
            -- Insert mode line toggle (i), example `{"<M-/>", "<M-_>"}`
            line_toggle_insert = '<M-/>',

            block_toggle = '',
            block_toggle_cur = '',
            block_toggle_visual = '',

            -- Linewise textobject (o)
            line_textobject = 'gc',
            -- Blockwise textobject (o)
            block_textobject = 'gcb',
            -- Auto textobject (o, x), example 'ga'
            auto_textobject = '',
            -- Auto uncomment (n), example `gcu`
            uncomment_auto = '',

            -- Insert comment below (n), example `gco`
            line_add_below = 'gco',
            -- Insert comment above (n), example `gcO`
            line_add_above = 'gcO',
            -- Insert comment at end of line (n), example `gcA`
            line_add_eol = 'gcA',

            -- Invert comment per line (n, x), example `gcI`
            line_invert = 'gcI',
            -- Force add line comment (n, x), example `gCC`
            line_force_add = '',
            -- Force remove line comment (n, x), example `gCU`
            line_force_remove = '',

            -- Cursor sticky dot-repeat
            dot_repeat = '.',
        },

        hooks = {
            -- Called before commit edits, receives context
            pre_commit_edits = nil,
            -- Called after commit edits, receives context
            post_commit_edits = nil,
            -- Custom comment string resolver function
            cms_conf_resolver = nil,
        },
    },
}
