return function()
  require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 100,
    },
    current_line_blame_formatter_opts = {
      relative_time = true,
    },
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
    },
  })
end
