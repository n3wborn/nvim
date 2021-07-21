-- https://github.com/TimUntersberger/neogit

local neogit = require("neogit")

neogit.setup {
  disable_signs = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  integrations = {
    diffview = false
  },
}
