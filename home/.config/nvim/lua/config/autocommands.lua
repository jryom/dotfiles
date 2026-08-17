local group = vim.api.nvim_create_augroup("ac", {})

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  command = "setlocal foldmethod=manual",
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  command = [[exe "silent norm! \<C-W>="]],
  group = group,
})

vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
  group = group,
  callback = function()
    local excluded_filetypes = { "markdown", "oil", "qf" }

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local filetype = vim.bo[buf].filetype
      if not vim.list_contains(excluded_filetypes, filetype) then
        local win_width = vim.api.nvim_win_get_width(win)
        if win_width < 100 then
          vim.api.nvim_set_option_value("number", false, { scope = "local", win = win })
          vim.api.nvim_set_option_value("relativenumber", false, { scope = "local", win = win })
        else
          vim.api.nvim_set_option_value("number", true, { scope = "local", win = win })
          vim.api.nvim_set_option_value("relativenumber", true, { scope = "local", win = win })
        end
      end
    end
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
