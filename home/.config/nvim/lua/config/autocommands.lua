local group = vim.api.nvim_create_augroup("ac", {})

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  command = "setlocal foldmethod=manual",
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  command = [[exe "silent norm! \<C-W>="]],
  group = group,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  group = group,
  callback = function()
    local numbers = not vim.list_contains({ "markdown", "oil", "qf" }, vim.bo.filetype)
    vim.wo.number = numbers
    vim.wo.relativenumber = numbers
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  command = "setlocal cursorline",
  group = group,
})

vim.api.nvim_create_autocmd("WinLeave", {
  command = "setlocal nocursorline",
  group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  command = "setlocal suffixesadd+=.js,.ts,.tsx,.jsx",
  group = group,
})

vim.api.nvim_create_autocmd({ "DirChanged", "UIEnter" }, {
  callback = function() vim.opt.titlestring = "nvim " .. require("config.paths").short_cwd() end,
  group = group,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  group = group,
  pattern = { "**/.github/**/*.yml", "**/.github/**/*.yaml" },
  callback = function() require("lint").try_lint("actionlint") end,
})
