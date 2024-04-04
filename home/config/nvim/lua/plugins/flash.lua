return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    label = {
      min_pattern_length = 2,
    },
    modes = {
      char = {
        enabled = false,
      },
    },
  },
  keys = {
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
  },
}
