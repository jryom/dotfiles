return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  keys = {
    {
      "<space>F",
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        if vim.b.disable_autoformat then
          return vim.notify("Disabled automatic formatting for buffer")
        end
        vim.notify("Enabled automatic formatting enabled for buffer")
      end,
      desc = "Toggle autoformatting for buffer",
      silent = true,
    },
  },
  opts = {
    formatters = {
      shfmt = {
        args = { "-filename", "$FILENAME", "-i", "2" },
      },
    },
    formatters_by_ft = {
      ["*"] = { "trim_whitespace", "trim_newlines" },
      fish = { "fish_indent" },
      go = { "gofmt", "goimports" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      json5 = { "prettier" },
      jsonc = { "prettier" },
      justfile = { "just" },
      lua = { "stylua" },
      markdown = { "markdownlint", "prettier" },
      python = { "isort", "black" },
      sh = { "shfmt" },
      terraform = { "terraform_fmt" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      yaml = { "prettier" },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_fallback = true }
    end,
  },
}
