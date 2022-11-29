local group = vim.api.nvim_create_augroup("ac", {})

-- close floating windows before closing as they will otherwise mess up session restoration
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= "" then vim.api.nvim_win_close(win, false) end
    end
  end,
  group = group,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  command = "if &buftype == 'help' | wincmd L | endif",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  command = "if getfsize(expand('%')) > 100 * 1024 | syntax off | endif",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.{eslint,babel,stylelint,prettier}rc" },
  command = "set ft=json5",
  group = group,
})

vim.api.nvim_create_autocmd({ "SessionLoadPost", "VimResized" }, {
  command = [[exe ":norm! \<C-W>="]],
  group = group,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  command = "setlocal cursorline | autocmd WinLeave * setlocal nocursorline",
  group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  command = "setlocal suffixesadd+=.js,.ts,.tsx,.jsx",
  group = group,
})
