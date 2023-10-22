return {
  "andythigpen/nvim-coverage",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    {
      "<space>c",
      ":Coverage<cr>",
      desc = "Coverage",
      silent = true,
    },
    {
      "<space>C",
      ":CoverageSummary<cr>",
      desc = "Coverage summary",
      silent = true,
    },
  },
  opts = {
    auto_reload = true,
    highlights = {
      uncovered = { link = "DiagnosticError" },
      partial = { link = "DiagnosticWarn" },
    },
    signs = {
      covered = { text = "" },
      uncovered = { text = "▒" },
      partial = { text = "▒" },
    },
  },
}
