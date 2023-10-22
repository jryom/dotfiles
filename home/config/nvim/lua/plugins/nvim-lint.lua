return {
  "mfussenegger/nvim-lint",
  init = function()
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "TextChanged", "TextChangedI" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
  config = function()
    require("lint").linters_by_ft = {
      dockerfile = { "hadolint" },
      gitcommit = { "commitlint" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      yaml = { "actionlint" },
    }
  end,
}
