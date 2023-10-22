return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
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
