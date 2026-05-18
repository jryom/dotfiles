vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
  bigfile = { enabled = true },
  indent = { enabled = true, indent = { char = "▏" }, scope = { char = "▏" } },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  styles = {
    notification = { wo = { wrap = true } },
    zen = {
      width = 160,
      backdrop = { transparent = true, blend = 40 },
      zindex = 80,
    },
  },
  words = { enabled = true, debounce = 1000 },
})

vim.keymap.set("n", "gn", function() Snacks.words.jump(vim.v.count1, true) end, { desc = "Next Reference" })
vim.keymap.set("n", "gN", function() Snacks.words.jump(-vim.v.count1, true) end, { desc = "Prev Reference" })
