---@diagnostic disable: missing-fields
return {
  "folke/snacks.nvim",
  priority = 1000,
  version = "*",
  lazy = false,
  config = function()
    require("snacks").setup({
      bigfile = { enabled = true },
      indent = { enabled = true, chunk = { enabled = true, only_current = true } },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      styles = { notification = { wo = { wrap = true } } },
      toggle = { enabled = true },
      words = { enabled = true, debounce = 1000 },
    })
  end,
  keys = {
    { "<space>gt", function() Snacks.toggle() end, desc = "Toggle settings" },
    { "<space>lf", function() Snacks.rename() end, desc = "Rename File" },
    { "gn", function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next Reference" },
    { "gN", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev Reference" },
  },
}
