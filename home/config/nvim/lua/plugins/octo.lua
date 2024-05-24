return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
  },
  cmd = {
    "Octo",
  },
  opts = {
    picker = "fzf-lua",
    file_panel = {
      use_icons = false,
    },
  },
}
