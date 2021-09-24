return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
    })
  end,
}
