---@type LazySpec[]
return {
  "linrongbin16/gitlinker.nvim",
  version = "*",
  keys = {
    {
      "<space>gl",
      ":GitLink<CR>",
      desc = "Copy git permlink to clipboard",
      silent = true,
      mode = { "x", "n" },
    },
    {
      "<space>gL",
      ":GitLink!<CR>",
      desc = "Open git permlink in browser",
      silent = true,
      mode = { "x", "n" },
    },
  },
  config = function() require("gitlinker").setup() end,
}
