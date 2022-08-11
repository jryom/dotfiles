local map = vim.keymap.set

map(
  "n",
  "dd",
  "<Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>",
  { silent = true, buffer = true }
)
