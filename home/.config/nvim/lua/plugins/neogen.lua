return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
     snippet_engine = "luasnip"
  },
  keys = function()
    return {
      {
        "<space>df",
        ":Neogen func<cr>",
        desc = "Function",
        silent = true,
      },
      {
        "<space>dF",
        ":Neogen file<cr>",
        desc = "File",
        silent = true,
      },
      {
        "<space>dt",
        ":Neogen type<cr>",
        desc = "Type",
        silent = true,
      },
      {
        "<space>dc",
        ":Neogen class<cr>",
        desc = "class",
        silent = true,
      },
    }
  end,
}
