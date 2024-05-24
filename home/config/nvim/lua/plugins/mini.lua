return {
  {
    "echasnovski/mini.basics",
    key = { { "yo" } },
    opts = {
      mappings = {
        option_toggle_prefix = "yo",
      },
    },
  },
  {
    "echasnovski/mini.bracketed",
    keys = {
      { "<left>", "[", mode = { "n", "x", "o" }, remap = true },
      { "<right>", "]", mode = { "n", "x", "o" }, remap = true },
    },
    event = "VeryLazy",
    opts = {},
  },
}
