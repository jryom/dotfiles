require("utils")

return function()
  local mode = os.capture("defaults read -g AppleInterfaceStyle 2>/dev/null")

  if mode == "Dark" then
    vim.opt.background = "dark"
  else
    vim.opt.background = "light"
  end

  vim.cmd("colorscheme zenbones")
end
