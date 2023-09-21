return {
  "lewis6991/gitsigns.nvim",
  event = "CursorHold",
  init = function()
    local map = require("which-key").register
    map({ ["<space>g"] = { name = "Git" } })
  end,
  keys = {
    { "<space>gn", ":Gitsigns next_hunk<cr>", desc = "Next hunk", silent = true },
    { "<space>gp", ":Gitsigns prev_hunk<cr>", desc = "Previous hunk", silent = true },
  },
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text_priority = 1000,
    },
    current_line_blame_formatter_opts = {
      relative_time = true,
    },
  },
}
