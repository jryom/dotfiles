vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

require("grug-far").setup({})

vim.keymap.set({ "x", "n" }, "<space>s", ":GrugFar<CR>", { desc = "Find and replace", silent = true })
