return {
    'saghen/blink.cmp',
    dependencies = {
        'Kaiser-Yang/blink-cmp-git',
        'rafamadriz/friendly-snippets',
        'mikavilpas/blink-ripgrep.nvim',
        'disrupted/blink-cmp-conventional-commits',
    },

    version = '1.*',
    build = 'cargo build --release',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        use_frecency = true,
        completion = {
            documentation = {
                auto_show = true,
            },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                },
            },
            fuzzy = {
                -- Controls which implementation to use for the fuzzy matcher.
                --
                -- 'prefer_rust_with_warning' (Recommended) If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available, emitting a warning message.
                -- 'prefer_rust' If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available.
                -- 'rust' Always use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Error if not available.
                -- 'lua' Always use the Lua implementation, doesn't download any prebuilt binaries
                --
                -- See the prebuilt_binaries section for controlling the download behavior
                implementation = 'prefer_rust_with_warning',

                -- Note, this does not apply when using the Lua implementation.
                max_typos = function(keyword)
                    return math.floor(#keyword / 4)
                end,

                -- Frecency tracks the most recently/frequently used items and boosts the score of the item
                -- Note, this does not apply when using the Lua implementation.
                use_frecency = true,

                -- Proximity bonus boosts the score of items matching nearby words
                -- Note, this does not apply when using the Lua implementation.
                use_proximity = true,

                -- UNSAFE!! When enabled, disables the lock and fsync when writing to the frecency database. This should only be used on unsupported platforms (i.e. alpine termux)
                -- Note, this does not apply when using the Lua implementation.
                use_unsafe_no_lock = false,

                -- Controls which sorts to use and in which order, falling back to the next sort if the first one returns nil
                -- You may pass a function instead of a string to customize the sorting
                sorts = {
                    -- (optionally) always prioritize exact matches
                    -- 'exact',

                    -- pass a function for custom behavior
                    -- function(item_a, item_b)
                    --   return item_a.score > item_b.score
                    -- end,

                    'score',
                    'sort_text',
                },

                prebuilt_binaries = {
                    -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`,
                    -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
                    -- Disabled by default when `fuzzy.implementation = 'lua'`
                    download = true,

                    -- Ignores mismatched version between the built binary and the current git sha, when building locally
                    ignore_version_mismatch = false,

                    -- When downloading a prebuilt binary, force the downloader to resolve this version. If this is unset
                    -- then the downloader will attempt to infer the version from the checked out git tag (if any).
                    --
                    -- Beware that if the fuzzy matcher changes while tracking main then this may result in blink breaking.
                    force_version = nil,

                    -- When downloading a prebuilt binary, force the downloader to use this system triple. If this is unset
                    -- then the downloader will attempt to infer the system triple from `jit.os` and `jit.arch`.
                    -- Check the latest release for all available system triples
                    force_system_triple = nil,
                    extra_curl_args = {},
                    proxy = {
                        from_env = true,
                        url = nil,
                    },
                },
            },
        },
        keymap = {
            preset = 'enter',
            ['<c-g>'] = {
                function()
                    require('blink-cmp').show({ providers = { 'ripgrep' } })
                end,
            },
        },
        signature = { enabled = false },
        sources = {
            default = {
                'lsp',
                'buffer',
                'ripgrep',
                'path',
                'snippets',
                'conventional_commits',
            },
            providers = {
                conventional_commits = {
                    name = 'Conventional Commits',
                    module = 'blink-cmp-conventional-commits',
                    enabled = function()
                        return vim.bo.filetype == 'gitcommit'
                    end,
                    ---@module 'blink-cmp-conventional-commits'
                    ---@type blink-cmp-conventional-commits.Options
                    opts = {}, -- none so far
                },
                ripgrep = {
                    module = 'blink-ripgrep',
                    name = 'Ripgrep',
                    -- the options below are optional, some default values are shown
                    ---@module "blink-ripgrep"
                    ---@type blink-ripgrep.Options
                    opts = {
                        -- the minimum length of the current word to start searching
                        -- (if the word is shorter than this, the search will not start)
                        prefix_min_len = 3,

                        -- Specifies how to find the root of the project where the ripgrep
                        -- search will start from. Accepts the same options as the marker
                        -- given to `:h vim.fs.root()` which offers many possibilities for
                        -- configuration. If none can be found, defaults to Neovim's cwd.
                        --
                        -- Examples:
                        -- - ".git" (default)
                        -- - { ".git", "package.json", ".root" }
                        project_root_marker = '.git',

                        -- When a result is found for a file whose filetype does not have a
                        -- treesitter parser installed, fall back to regex based highlighting
                        -- that is bundled in Neovim.
                        fallback_to_regex_highlighting = true,

                        -- Keymaps to toggle features on/off. This can be used to alter
                        -- the behavior of the plugin without restarting Neovim. Nothing
                        -- is enabled by default. Requires folke/snacks.nvim.
                        toggles = {
                            -- The keymap to toggle the plugin on and off from blink
                            -- completion results. Example: "<leader>tg" ("toggle grep")
                            on_off = nil,

                            -- The keymap to toggle debug mode on/off. Example: "<leader>td" ("toggle debug")
                            debug = nil,
                        },

                        backend = {
                            -- The backend to use for searching. Defaults to "ripgrep".
                            -- Available options:
                            -- - "ripgrep", always use ripgrep
                            -- - "gitgrep", always use git grep
                            -- - "gitgrep-or-ripgrep", use git grep if possible, otherwise
                            --   use ripgrep
                            use = 'ripgrep',

                            -- Whether to set up custom highlight-groups for the icons used
                            -- in the completion items. Defaults to `true`, which means this
                            -- is enabled.
                            customize_icon_highlight = true,

                            ripgrep = {
                                -- For many options, see `rg --help` for an exact description of
                                -- the values that ripgrep expects.

                                -- The number of lines to show around each match in the preview
                                -- (documentation) window. For example, 5 means to show 5 lines
                                -- before, then the match, and another 5 lines after the match.
                                context_size = 5,

                                -- The maximum file size of a file that ripgrep should include
                                -- in its search. Useful when your project contains large files
                                -- that might cause performance issues.
                                -- Examples:
                                -- "1024" (bytes by default), "200K", "1M", "1G", which will
                                -- exclude files larger than that size.
                                max_filesize = '1M',

                                -- Enable fallback to neovim cwd if project_root_marker is not
                                -- found. Default: `true`, which means to use the cwd.
                                project_root_fallback = true,

                                -- The casing to use for the search in a format that ripgrep
                                -- accepts. Defaults to "--ignore-case". See `rg --help` for
                                -- all the available options ripgrep supports, but you can try
                                -- "--case-sensitive" or "--smart-case".
                                search_casing = '--ignore-case',

                                -- (advanced) Any additional options you want to give to
                                -- ripgrep. See `rg -h` for a list of all available options.
                                -- Might be helpful in adjusting performance in specific
                                -- situations. If you have an idea for a default, please open
                                -- an issue!
                                --
                                -- Not everything will work (obviously).
                                additional_rg_options = {},

                                -- Absolute root paths where the rg command will not be
                                -- executed. Usually you want to exclude paths using gitignore
                                -- files or ripgrep specific ignore files, but this can be used
                                -- to only ignore the paths in blink-ripgrep.nvim, maintaining
                                -- the ability to use ripgrep for those paths on the command
                                -- line. If you need to find out where the searches are
                                -- executed, enable `debug` and look at `:messages`.
                                ignore_paths = {},

                                -- Any additional paths to search in, in addition to the
                                -- project root. This can be useful if you want to include
                                -- dictionary files (/usr/share/dict/words), framework
                                -- documentation, or any other reference material that is not
                                -- available within the project root.
                                additional_paths = {},
                            },
                        },

                        -- Show debug information in `:messages` that can help in
                        -- diagnosing issues with the plugin.
                        debug = false,
                    },
                    -- (optional) customize how the results are displayed. Many options
                    -- are available - make sure your lua LSP is set up so you get
                    -- autocompletion help
                    transform_items = function(_, items)
                        for _, item in ipairs(items) do
                            -- example: append a description to easily distinguish rg results
                            item.labelDetails = {
                                description = '(rg)',
                            }
                        end
                        return items
                    end,
                },
            },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
}
