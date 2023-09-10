return {
  "zbirenbaum/copilot.lua",
  dependencies = "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
    require("copilot_cmp").setup({
      formatters = {
        insert_text = require("copilot_cmp.format").remove_existing,
      },
    })
  end,
}
