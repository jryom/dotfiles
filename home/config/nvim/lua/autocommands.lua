local group = vim.api.nvim_create_augroup("ac", {})

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  command = "setlocal foldmethod=manual",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.{eslint,babel,stylelint,prettier,swc}rc" },
  command = "set ft=json",
  group = group,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.ain" },
  command = "set ft=dosini",
  group = group,
})

vim.api.nvim_create_autocmd({ "SessionLoadPost", "VimResized" }, {
  command = [[exe "silent norm! \<C-W>="]],
  group = group,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    local width = vim.api.nvim_get_option("columns")
    if width > 250 and vim.bo.filetype ~= "gitcommit" then
      vim.cmd("NvimTreeOpen")
    else
      pcall(function()
        vim.cmd("NvimTreeClose")
      end)
    end
  end,
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

vim.api.nvim_create_autocmd({ "DirChanged", "SessionLoadPost", "UIEnter" }, {
  callback = function()
    local cwd = function()
      local cwd = vim.loop.cwd()
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
  callback = function()
    require("lint").try_lint("actionlint")
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter" }, {
  group = group,
  callback = function()
    local api = require("nvim-tree.api")
    api.tree.collapse_all(true)
  end,
})
