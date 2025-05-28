---@type LazySpec
return {
  "folke/trouble.nvim",
  version = "*",
  cmd = "Trouble",
  keys = {
    {
      "<leader>xd",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics",
    },
    {
      "<leader>xl",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List",
    },
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List",
    },
  },
  init = function() require("which-key").add({ "<space>x", group = "Trouble" }) end,
  config = function()
    require("trouble").setup({
      auto_close = true,
      auto_preview = false,
      auto_jump = false,
      modes = {
        diagnostics = {
          filter = {
            any = {
              {
                severity = vim.diagnostic.severity.ERROR,
              },
              {
                severity = vim.diagnostic.severity.WARN,
              },
            },
          },
        },
      },
    })
  end,
}
