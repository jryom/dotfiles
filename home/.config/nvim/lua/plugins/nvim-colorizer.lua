return {
  "nvchad/nvim-colorizer.lua",
  event = "VeryLazy",
  config = function()
    require("colorizer").setup({
      user_default_options = {
        AARRGGBB = true,
        RGB = false,
        RRGGBBAA = true,
        names = false,
      },
    })
  end,
}
