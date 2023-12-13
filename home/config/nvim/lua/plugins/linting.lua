return {
  {
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
        yaml = { "actionlint" },
        zsh = { "zsh" },
      }
    end,
  },

  {
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
        markdown = { "markdownlint-cli2", "prettier" },
        python = { "ruff_fix", "ruff_format", "isort", "black" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        toml = { "taplo" },
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
  },

  {
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "typescriptreact" },
    opts = {
      auto_close_qflist = true,
      auto_start_watch_mode = true,
      enable_progress_notifications = false,
      flags = { watch = true },
    },
  },
}
