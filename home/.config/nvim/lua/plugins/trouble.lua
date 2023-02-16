return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  config = function()
    require("trouble").setup({
      auto_close = true,
      auto_fold = false,
      auto_jump = { "lsp_definitions", "lsp_type_definitions", "lsp_references" },
      auto_preview = true,
      height = 6,
      icons = false,
      padding = false,
      use_diagnostic_signs = true,
    })
  end,
}
