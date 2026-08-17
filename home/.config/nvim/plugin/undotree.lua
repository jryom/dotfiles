vim.pack.add({ "https://github.com/mbbill/undotree" })

vim.g.undotree_DiffAutoOpen = 0
vim.g.undotree_HelpLine = 0
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_TreeNodeShape = "├"
vim.g.undotree_TreeVertShape = "│"
vim.g.undotree_TreeSplitShape = "─┘"
vim.g.undotree_TreeReturnShape = "─┐"

vim.keymap.set("n", "<space>u", ":UndotreeToggle<cr>", { desc = "Undotree", silent = true })
