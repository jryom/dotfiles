return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  event = { "CmdlineEnter", "InsertEnter" },
  version = "*",
  config = function()
    require("blink.cmp").setup({
      keymap = {
        ["<C-space>"] = { "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "show", "select_next", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-l>"] = { "snippet_forward", "select_and_accept", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
      },
      completion = { documentation = { auto_show = true } },
    })
  end,
}
