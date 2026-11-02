vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
  bigfile = { enabled = true },
  indent = { enabled = true, indent = { char = "▏" }, scope = { char = "▏" } },
  input = { enabled = true },
  notifier = { enabled = true },
  picker = { enabled = true, ui_select = false },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  styles = {
    notification = { wo = { wrap = true } },
  },
  words = { enabled = true, debounce = 1000 },
})

vim.keymap.set("n", "gn", function() Snacks.words.jump(vim.v.count1, true) end, { desc = "Next Reference" })
vim.keymap.set("n", "gN", function() Snacks.words.jump(-vim.v.count1, true) end, { desc = "Prev Reference" })

vim.keymap.set({ "x", "n" }, "<space>gl", function()
  Snacks.gitbrowse({ what = "permalink", open = function(url) vim.fn.setreg("+", url) end, notify = false })
end, { desc = "Copy git permalink to clipboard", silent = true })
vim.keymap.set({ "x", "n" }, "<space>gL", function() Snacks.gitbrowse({ what = "permalink" }) end, {
  desc = "Open git permalink in browser",
  silent = true,
})
vim.keymap.set("n", "<space>u", function() Snacks.picker.undo() end, { desc = "Undo history", silent = true })
