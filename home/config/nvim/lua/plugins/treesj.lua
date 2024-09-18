return {
  "wansmer/treesj",
  keys = { { "<space>j", function() require("treesj").toggle() end, desc = "Split/join", silent = true } },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({
      use_default_keymaps = false,
    })
  end,
}
