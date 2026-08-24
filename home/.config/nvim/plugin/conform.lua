vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
  formatters = {
    ["biome-check"] = { require_cwd = true },
    prettier = { require_cwd = true },
    shfmt = { args = { "-filename", "$FILENAME", "-i", "2" } },
    sqlfluff = { args = { "fix", "--dialect=postgres", "-" } },
  },
  formatters_by_ft = {
    fish = { "fish_indent" },
    javascript = { "biome-check", "prettier", stop_after_first = true },
    javascriptreact = { "biome-check", "prettier", stop_after_first = true },
    json = { "biome-check", "prettier", stop_after_first = true },
    json5 = { "biome-check", "prettier", stop_after_first = true },
    jsonc = { "biome-check", "prettier", stop_after_first = true },
    lua = { "stylua" },
    markdown = { "prettier" },
    python = { "ruff_fix", "ruff_format" },
    sh = { "shfmt" },
    sql = { "sqlfluff" },
    terraform = { "terraform_fmt" },
    toml = { "taplo" },
    typescript = { "biome-check", "prettier", stop_after_first = true },
    typescriptreact = { "biome-check", "prettier", stop_after_first = true },
    yaml = { "prettier" },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,
})

vim.keymap.set("n", "yof", function()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  if vim.b.disable_autoformat then return vim.notify("Disabled automatic formatting for buffer") end
  vim.notify("Enabled automatic formatting for buffer")
end, { desc = "Toggle autoformatting for buffer", silent = true })
