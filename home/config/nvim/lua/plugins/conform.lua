---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  keys = {
    {
      "<space>F",
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        if vim.b.disable_autoformat then return vim.notify("Disabled automatic formatting for buffer") end
        vim.notify("Enabled automatic formatting enabled for buffer")
      end,
      desc = "Toggle autoformatting for buffer",
      silent = true,
    },
  },
  config = function()
    require("conform").setup({
      formatters = {
        prettier = {
          require_cwd = true,
        },
        biome = {
          require_cwd = true,
        },
        shfmt = {
          args = { "-filename", "$FILENAME", "-i", "2" },
        },
        sqlfluff = {
          args = { "fix", "--dialect=postgres", "-" },
        },
      },
      formatters_by_ft = {
        ["*"] = { "trim_whitespace", "trim_newlines" },
        fish = { "fish_indent" },
        go = { "gofmt", "goimports" },
        javascript = { { "biome", "prettier" } },
        javascriptreact = { { "biome", "prettier" } },
        json = { { "biome", "prettier" } },
        json5 = { { "biome", "prettier" } },
        jsonc = { { "biome", "prettier" } },
        justfile = { "just" },
        lua = { "stylua" },
        markdown = { "markdownlint-cli2", "prettier" },
        python = { "ruff_fix", "ruff_format", "isort", "black" },
        sh = { "shfmt" },
        sql = { "sqlfluff" },
        terraform = { "terraform_fmt" },
        toml = { "taplo" },
        typescript = { { "biome", "prettier" } },
        typescriptreact = { { "biome", "prettier" } },
        yaml = { "prettier" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return { timeout_ms = 1000, lsp_fallback = true }
      end,
    })
  end,
}
