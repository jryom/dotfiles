return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      go = { "gofmt", "goimports" },
      justfile = { "just" },
      python = { "isort", "black" },
      javascript = { "prettier", "eslint_d" },
      javascriptreact = { "prettier", "eslint_d" },
      typescript = { "prettier", "eslint_d" },
      typescriptreact = { "prettier", "eslint_d" },
      ["*"] = { "trim_whitespace", "trim_newlines" },
    },
    format_on_save = { timeout_ms = 1000, lsp_fallback = true },
  },
}
