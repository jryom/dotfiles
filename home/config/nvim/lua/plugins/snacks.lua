return {
  "folke/snacks.nvim",
  priority = 1000,
  version = "*",
  lazy = false,
  config = function()
    require("snacks").setup({
      bigfile = { enabled = true },
      lazygit = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      styles = { notification = { wo = { wrap = true } } },
      words = { enabled = true, debounce = 1000 },
    })
  end,
  keys = {
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>lf", function() Snacks.rename() end, desc = "Rename File" },
    { "gn", function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next Reference" },
    { "gN", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev Reference" },
  },
}
