---@type LazySpec
return {
  "magicduck/grug-far.nvim",
  keys = {
    {
      "<space>s",
      ":GrugFar<CR>",
      desc = "Find and replace",
      silent = true,
      mode = { "x", "n" },
    },
  },
  config = function() require("grug-far").setup({}) end,
}
