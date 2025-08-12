---@module "lazy.types"
---@type LazyPluginSpec
return {
    'chrisgrieser/nvim-tinygit',
    event = 'VeryLazy', -- load for status line component
    keys = {
		-- stylua: ignore start
		{ "<space>gg", function() require("tinygit").smartCommit { pushIfClean = true } end, desc = "󰊢 Smart-commit & push", nowait = true },
		{ "<leader>gc", function() require("tinygit").smartCommit { pushIfClean = false } end, desc = "󰊢 Smart-commit" },
		{ "<leader>gp", function() require("tinygit").push { pullBefore = true } end, desc = "󰊢 Pull & push" },
		{ "<leader>gP", function() require("tinygit").push { createGitHubPr = true } end, desc = " Push & PR" },
		{ "<leader>gf", function() require("tinygit").fixupCommit { autoRebase = true } end, desc = "󰊢 Fixup-commit & rebase" },
		{ "<leader>gm", function() require("tinygit").amendNoEdit { forcePushIfDiverged = true } end, desc = "󰊢 Amend-commit & f-push" },
		{ "<leader>gM", function() require("tinygit").amendOnlyMsg { forcePushIfDiverged = true } end, desc = "󰊢 Amend message & f-push" },
		{ "<leader>gi", function() require("tinygit").issuesAndPrs { state = "open" } end, desc = " Open issues" },
		{ "<leader>gI", function() require("tinygit").issuesAndPrs { state = "closed" } end, desc = " Closed issues" },
		{ "<leader>gh", function() require("tinygit").fileHistory() end, mode = { "n", "x" }, desc = "󰋚 File history" },
		{ "<leader>gu", function() require("tinygit").githubUrl("file") end, mode = { "n", "x" }, desc = " GitHub line URL" },
		{ "<leader>gU", function() require("tinygit").githubUrl("repo") end, mode = { "n", "x" }, desc = " GitHub repo URL" },
		{ "<leader>g!", function() require("tinygit").githubUrl("blame") end, mode = { "n", "x" }, desc = " GitHub blame" },
		{ "<leader>gt", function() require("tinygit").stashPush() end, desc = "󰜦 Stash" },
		{ "<leader>gT", function() require("tinygit").stashPop() end, desc = "󰜦 Stash pop" },

		{ "gi", function() require("tinygit").openIssueUnderCursor() end, desc = " Open issue under cursor" },

		{ "<leader>uc", function() require("tinygit").undoLastCommitOrAmend() end, desc = "󰊢 Undo last commit/amend" },
        -- stylua: ignore end
    },
    opts = {
        stage = {
            moveToNextHunkOnStagingToggle = true,
        },
        commit = {
            keepAbortedMsgSecs = 60 * 10, -- 10 mins
            spellcheck = true,
            subject = {
                autoFormat = function(subject)
                    -- remove trailing dot https://commitlint.js.org/reference/rules.html#body-full-stop
                    subject = subject:gsub('%.$', '')

                    -- sentence case of title after the type
                    subject = subject
                        :gsub('^(%w+: )(.)', function(c1, c2)
                            return c1 .. c2:lower()
                        end) -- no scope
                        :gsub('^(%w+%b(): )(.)', function(c1, c2)
                            return c1 .. c2:lower()
                        end) -- with scope
                    return subject
                end,
                enforceType = true,
            },
        },
        push = {
            openReferencedIssues = true,
        },
        history = {
            autoUnshallowIfNeeded = true,
            diffPopup = {
                width = 0.9,
                height = 0.9,
            },
        },
        statusline = {
            blame = {
                ignoreAuthors = { '🤖 automated' },
                maxMsgLen = 72,
            },
        },
    },
    config = function(_, opts)
        require('tinygit').setup(opts)
    end,
}
