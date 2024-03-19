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

  {
    "echasnovski/mini.comment",
    dependencies = "joosepalviste/nvim-ts-context-commentstring",
    keys = { { "gc", mode = { "x", "n" } }, { "gcc", mode = { "x", "n" } } },
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
}
