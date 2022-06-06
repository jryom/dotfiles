local group = vim.api.nvim_create_augroup("ac", {})

-- close floating windows before closing as they will otherwise mess up session restoration
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= "" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end,
  group = group,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  command = "syntax sync fromstart",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  command = "if &buftype == 'help' | wincmd L | endif",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.{eslint,babel,stylelint,prettier}rc" },
  command = "set ft=json5",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.lua" },
  command = "silent! !stylua --config-path ~/.config/stylua.toml %:p",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.lua" },
  command = "silent! edit",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "plugins.lua" },
  command = "source <afile> | PackerSync",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*nvim/*.lua" },
  command = "source <afile> | PackerCompile",
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

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "netrw" },
  callback = function()
    vim.cmd([[
      nmap <buffer> h -
      nmap <buffer> l <CR>
    ]])
  end,
  group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf" },
  command = "nnoremap <buffer> <silent> dd <Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>",
  group = group,
})
