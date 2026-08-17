vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.basics").setup()
require("mini.bracketed").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.bufremove").setup()

vim.keymap.set({ "n", "x", "o" }, "<left>", "[", { remap = true })
vim.keymap.set({ "n", "x", "o" }, "<right>", "]", { remap = true })

vim.keymap.set("n", "Qt", function() MiniBufremove.wipeout(0) end, { desc = "Delete this buffer" })
vim.keymap.set("n", "Qa", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then MiniBufremove.wipeout(buf) end
  end
end, { desc = "Delete all buffers" })
vim.keymap.set("n", "Qh", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= cur and vim.fn.bufwinid(buf) == -1 then
      MiniBufremove.wipeout(buf)
    end
  end
end, { desc = "Delete hidden buffers" })
vim.keymap.set("n", "Qo", function()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= cur then MiniBufremove.wipeout(buf) end
  end
end, { desc = "Delete other buffers" })
