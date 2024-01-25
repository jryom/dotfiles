return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {},
  keys = {
    {
      "<space>ac",
      ":Neogen class<cr>",
      desc = "Generate class annotation",
      silent = true,
    },
    {
      "<space>af",
      ":Neogen function<cr>",
      desc = "Generate function annotation",
      silent = true,
    },
    {
      "<space>aF",
      ":Neogen file<cr>",
      desc = "Generate file annotation",
      silent = true,
    },
    {
      "<space>at",
      ":Neogen type<cr>",
      desc = "Generate type annotation",
      silent = true,
    },
  },
}
