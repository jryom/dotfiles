local map = vim.keymap.set

vim.opt_local.number = false
vim.opt_local.relativenumber = false

map(
  "n",
  "dd",
  "<Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>",
  { silent = true, buffer = true }
)
