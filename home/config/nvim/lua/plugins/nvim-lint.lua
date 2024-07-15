---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  lazy = true,
  config = function()
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "TextChanged", "TextChangedI" }, {
      callback = function() require("lint").try_lint() end,
    })

    local lint = require("lint")

    lint.linters.markdownlint_cli2 = {
      name = "markdownlint-cli2",
      cmd = "markdownlint-cli2",
      ignore_exitcode = true,
      stream = "stderr",
      parser = require("lint.parser").from_errorformat("%f:%l:%c %m,%f:%l %m", {
        source = "markdownlint-cli2",
        severity = vim.diagnostic.severity.WARN,
      }),
    }

    lint.linters_by_ft = {
      dockerfile = { "hadolint" },
      gitcommit = { "commitlint" },
      make = { "checkmake" },
      markdown = { "markdownlint_cli2" },
      python = { "ruff" },
      sql = { "sqlfluff" },
      zsh = { "zsh" },
    }

    lint.linters.sqlfluff.args = {
      "lint",
      "--format=json",
      "--dialect=postgres",
    }
  end,
}
