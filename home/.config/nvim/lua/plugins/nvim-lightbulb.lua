return {
  "kosayoda/nvim-lightbulb",
  event = "CursorHold",
  config = function()
    vim.fn.sign_define("LightBulbSign", { text = " ", texthl = "LspDiagnosticsDefaultInformation" })
    require("nvim-lightbulb").setup({
      autocmd = {
        enabled = true,
        pattern = { "*" },
        events = { "CursorHold", "CursorHoldI" },
      },
    })
  end,
}
