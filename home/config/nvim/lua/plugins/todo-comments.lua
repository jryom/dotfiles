---@type LazySpec
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    require("todo-comments").setup({
      signs = false,
    })
  end,
}
