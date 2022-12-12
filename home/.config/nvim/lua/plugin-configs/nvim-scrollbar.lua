return function()
  require("scrollbar").setup({
    handle = { highlight = "StatusLine" },
    handlers = { cursor = false },
    excluded_buftypes = {
      "terminal",
      "nofile",
    },
  })
end
