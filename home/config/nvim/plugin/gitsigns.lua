vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "✳" },
  },
})

vim.keymap.set("n", "<space>gb", ":Gitsigns blame_line<CR>", { desc = "Blame line", silent = true })
vim.keymap.set("n", "yog", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle current line blame", silent = true })
vim.keymap.set({ "x", "n" }, "<space>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk", silent = true })
vim.keymap.set({ "x", "n" }, "<space>gR", ":Gitsigns reset_buffer<CR>", { desc = "Reset buffer", silent = true })
vim.keymap.set("n", "<space>gn", ":Gitsigns next_hunk<CR>", { desc = "Next hunk", silent = true })
vim.keymap.set("n", "<space>gp", ":Gitsigns prev_hunk<CR>", { desc = "Prev hunk", silent = true })
