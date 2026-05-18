vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

require("diffview").setup({
  file_panel = { listing_style = "list" },
  show_help_hints = false,
})

vim.keymap.set("n", "<space>gd", ":DiffviewOpen<cr>", { desc = "Diff", silent = true })
vim.keymap.set("n", "<space>gh", ":DiffviewFileHistory %<cr>", { desc = "File history", silent = true })
