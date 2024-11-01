return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "v0.*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
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
    accept = { create_undo_point = true },
    windows = {
      autocomplete = {
        min_width = 20,
        max_height = 20,
        auto_show = true,
        selection = "auto_insert",
      },
      documentation = {
        min_width = 10,
        max_width = 60,
        max_height = 20,
        border = "padded",
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },
    highlight = { use_nvim_cmp_as_default = true },
    blocked_filetypes = {},
  },
}
