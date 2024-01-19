return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true },
      panel = {
        auto_refresh = true,
        layout = {
          ratio = 0.2,
        },
      },
    })
  end,
}
