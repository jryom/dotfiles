return {
  "folke/snacks.nvim",
  priority = 1000,
  version = "*",
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    lazygit = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
  },
  keys = {
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>lf", function() Snacks.rename() end, desc = "Rename File" },
    { "gn", function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next Reference" },
    { "gN", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev Reference" },
  },
}
