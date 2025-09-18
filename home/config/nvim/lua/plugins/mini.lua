return {
  {
    "nvim-mini/mini.basics",
    event = "VeryLazy",
    key = { { "yo" } },
    opts = {},
  },
  {
    "nvim-mini/mini.bracketed",
    keys = {
      { "<left>", "[", mode = { "n", "x", "o" }, remap = true },
      { "<right>", "]", mode = { "n", "x", "o" }, remap = true },
    },
    opts = {},
  },
}
