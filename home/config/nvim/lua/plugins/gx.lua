---@type LazySpec
return {
  "chrishrb/gx.nvim",
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  dependencies = { "nvim-lua/plenary.nvim" },
  ---@diagnostic disable-next-line: missing-fields
  config = function() require("gx").setup({}) end,
}
