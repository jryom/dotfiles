return {
  "kosayoda/nvim-lightbulb",
  event = "CursorHold",
  config = function()
    require("nvim-lightbulb").setup({
      sign = { enabled = false },
      virtual_text = {
        enabled = true,
        text = "  ",
        hl_mode = "combine",
      },
      autocmd = {
        enabled = true,
        pattern = { "*" },
        events = { "CursorHold", "CursorHoldI" },
      },
    })
  end,
}
