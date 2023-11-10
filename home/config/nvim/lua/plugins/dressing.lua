return {
  "stevearc/dressing.nvim",
  lazy = true,
  init = function()
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
    vim.ui.input = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.input(...)
    end
  end,
  opts = {
    select = {
      enabled = true,
      backend = { "builtin" },
      builtin = {
        border = "rounded",
        relative = "cursor",
        min_width = { 1, 0 },
        min_height = { 1, 0 },
        mappings = {
          ["q"] = "Close",
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
      },
    },
  },
}
