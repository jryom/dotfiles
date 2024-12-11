---@type LazySpec[]
return {
  {
    "echasnovski/mini.basics",
    event = "VeryLazy",
    key = { { "yo" } },
    config = function()
      require("mini.basics").setup({
        mappings = {
          option_toggle_prefix = "yo",
        },
      })
    end,
  },
  {
    "echasnovski/mini.bracketed",
    keys = {
      { "<left>", "[", mode = { "n", "x", "o" }, remap = true },
      { "<right>", "]", mode = { "n", "x", "o" }, remap = true },
    },
    config = function() require("mini.bracketed").setup() end,
    event = "VeryLazy",
  },
}
