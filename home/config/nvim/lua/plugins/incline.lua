return {
  "b0o/incline.nvim",
  config = function()
    require("incline").setup({
      window = {
        overlap = { borders = true },
        margin = { vertical = 0 },
      },
      hide = { cursorline = "focused_win" },
    })
  end,
  event = "VeryLazy",
}
