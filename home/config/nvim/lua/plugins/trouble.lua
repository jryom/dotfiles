return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  keys = {
    {
      "q",
      ":TroubleToggle workspace_diagnostics<cr>",
      desc = "Workspace diagnostics",
      silent = true,
    },
  },
  opts = {
    auto_close = true,
    auto_fold = false,
    auto_jump = { "lsp_definitions", "lsp_type_definitions", "lsp_references" },
    auto_preview = true,
    padding = false,
    use_diagnostic_signs = true,
  },
}
