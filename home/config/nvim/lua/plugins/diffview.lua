---@type LazySpec[]
return {
  "sindrets/diffview.nvim",
  keys = {
    {
      "<space>gd",
      ":DiffviewOpen<cr>",
      desc = "Diff",
      silent = true,
    },
    {
      "<space>gh",
      ":DiffviewFileHistory %<cr>",
      desc = "File history",
      silent = true,
    },
  },
  config = function()
    require("diffview").setup({
      file_panel = {
        listing_style = "list",
      },
      show_help_hints = false,
    })
  end,
}
