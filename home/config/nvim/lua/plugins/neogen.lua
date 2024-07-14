---@type LazySpec
return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
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
  init = function() require("which-key").add({ "<space>G", group = "Annotate" }) end,
  config = function() require("neogen").setup({}) end,
}
