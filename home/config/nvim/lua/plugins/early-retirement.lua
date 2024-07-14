---@type LazySpec
return {
  "chrisgrieser/nvim-early-retirement",
  event = "VeryLazy",
  ---@diagnostic disable-next-line: missing-fields
  config = function() require("early-retirement").setup({ deleteBufferWhenFileDeleted = true }) end,
}
