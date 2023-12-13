return {
  "stevearc/aerial.nvim",
  keys = {
    { "<space>t", ":AerialToggle<cr>", desc = "Symbol outline", silent = true },
    { "<space>T", ":AerialNavToggle<cr>", desc = "Symbol navigator", silent = true },
  },
  opts = {
    attach_mode = "global",
    layout = {
      default_direction = "prefer_right",
      placement = "edge",
    },
    nav = {
      preview = true,
      keymaps = { ["q"] = "actions.close" },
    },
  },
}
