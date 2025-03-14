return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  keys = { { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Symbol outline" } },
  config = function()
    require("aerial").setup({
      layout = {
        max_width = { 60, 0.2 },
        default_direction = "right",
        placement = "edge",
      },
      attach_mode = "global",
      autojump = true,
      show_guides = true,
      keymaps = {
        ["<C-j>"] = "actions.tree_open",
        ["<C-k>"] = "actions.tree_close",
      },
    })
  end,
}
