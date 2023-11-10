return {
  "stevearc/aerial.nvim",
  keys = {
    { "<space>T", ":AerialToggle<cr>", desc = "Symbol outline", silent = true },
    { "<space>t", ":AerialNavToggle<cr>", desc = "Symbol navigator", silent = true },
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
    link_folds_to_tree = true,
    manage_folds = true,
  },
}
