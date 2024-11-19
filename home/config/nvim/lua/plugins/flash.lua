---@type LazySpec
return {
  "folke/flash.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "Flash",
    },
    {
      "r",
      mode = "o",
      function() require("flash").remote() end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function() require("flash").treesitter_search() end,
      desc = "Treesitter Search",
    },
  },
  config = function()
    require("flash").setup({
      label = {
        min_pattern_length = 2,
      },
      modes = {
        char = {
          enabled = false,
        },
        search = {
          enabled = false,
        },
      },
    })
  end,
}
