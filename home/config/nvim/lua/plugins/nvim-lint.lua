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
    require("lint").linters_by_ft = {
      dockerfile = { "hadolint" },
      gitcommit = { "commitlint" },
      markdown = { "markdownlint" },
      yaml = { "actionlint" },
      zsh = { "zsh" },
    }
  end,
}
