local map = vim.keymap.set

vim.opt_local.number = false
vim.opt_local.relativenumber = false

map("n", "dd", function()
  local row = vim.fn.line(".")
  local items = vim.fn.getqflist()
  table.remove(items, row)
  vim.fn.setqflist(items, "r")

  if #items == 0 then
    vim.cmd.cclose()
  else
    vim.cmd("cc " .. math.min(row, #items))
  end
end, { silent = true, buffer = true })
