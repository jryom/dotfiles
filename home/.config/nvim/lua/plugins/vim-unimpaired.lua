return {
  "tpope/vim-unimpaired",
  event = "VeryLazy",
  init = function()
    vim.keymap.set("n", "<left>", "[", { remap = true })
    vim.keymap.set("o", "<left>", "[", { remap = true })
    vim.keymap.set("x", "<left>", "[", { remap = true })
    vim.keymap.set("n", "<right>", "]", { remap = true })
    vim.keymap.set("o", "<right>", "]", { remap = true })
    vim.keymap.set("x", "<right>", "]", { remap = true })
  end,
}
