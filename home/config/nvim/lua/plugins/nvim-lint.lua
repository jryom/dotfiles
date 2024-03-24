return {
  "mfussenegger/nvim-lint",
  lazy = true,
  init = function()
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "TextChanged", "TextChangedI" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
  config = function()
    require("lint").linters.markdownlint_cli2 = {
      cmd = "markdownlint-cli2",
      ignore_exitcode = true,
      stream = "stderr",
      parser = require("lint.parser").from_errorformat("%f:%l:%c %m,%f:%l %m", {
        source = "markdownlint-cli2",
        severity = vim.diagnostic.severity.WARN,
      }),
    }
    require("lint").linters_by_ft = {
      dockerfile = { "hadolint" },
      gitcommit = { "commitlint" },
      markdown = { "markdownlint_cli2" },
      python = { "ruff" },
      -- yaml = { "actionlint" },
      zsh = { "zsh" },
    }
  end,
}
