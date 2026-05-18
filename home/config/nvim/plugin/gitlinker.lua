vim.pack.add({ "https://github.com/linrongbin16/gitlinker.nvim" })

require("gitlinker").setup()

vim.keymap.set({ "x", "n" }, "<space>gl", ":GitLink<CR>", { desc = "Copy git permlink to clipboard", silent = true })
vim.keymap.set({ "x", "n" }, "<space>gL", ":GitLink!<CR>", { desc = "Open git permlink in browser", silent = true })
