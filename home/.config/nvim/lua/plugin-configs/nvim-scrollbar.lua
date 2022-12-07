return function()
  require("scrollbar").setup({
    handle = { highlight = "StatusLine" },
    handlers = { gitsigns = true, cursor = false },
    marks = {
      GitAdd = {
        text = "│",
      },
      GitChange = {
        text = "│",
      },
    },
    excluded_buftypes = {
      "terminal",
      "nofile",
    },
  })
end
