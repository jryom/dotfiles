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
    local excluded_filetypes = { "markdown", "oil" }

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local filetype = vim.bo[buf].filetype
      local skip = false
      for _, ft in ipairs(excluded_filetypes) do
        if ft == filetype then
          skip = true
          break
        end
      end
      if not skip then
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
  command = "setlocal cursorline | autocmd WinLeave * setlocal nocursorline",
  group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  command = "setlocal suffixesadd+=.js,.ts,.tsx,.jsx",
  group = group,
})

vim.api.nvim_create_autocmd({ "DirChanged", "UIEnter" }, {
  callback = function()
    local cwd = function()
      local cwd = vim.uv.cwd()
      local home = os.getenv("HOME")

      return cwd:gsub(home, "~"):gsub("~/Code/", "")
    end

    vim.opt.titlestring = "nvim " .. cwd()
  end,
  group = group,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "BufReadPost", "BufNewFile" }, {
  group = group,
  pattern = { "**/.github/**/*.yml" },
  callback = function() require("lint").try_lint("actionlint") end,
})
