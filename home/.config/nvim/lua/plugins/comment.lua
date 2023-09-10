return {
  "numtostr/comment.nvim",
  event = "VeryLazy",
  dependencies = "joosepalviste/nvim-ts-context-commentstring",
  config = function()
    require("Comment").setup()
  end,
}
