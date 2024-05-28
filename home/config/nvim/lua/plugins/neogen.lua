return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {},
  keys = {
    {
      "<space>Gc",
      ":Neogen class<cr>",
      desc = "Generate class annotation",
      silent = true,
    },
    {
      "<space>Gf",
      ":Neogen function<cr>",
      desc = "Generate function annotation",
      silent = true,
    },
    {
      "<space>GF",
      ":Neogen file<cr>",
      desc = "Generate file annotation",
      silent = true,
    },
    {
      "<space>Gt",
      ":Neogen type<cr>",
      desc = "Generate type annotation",
      silent = true,
    },
  },
}
