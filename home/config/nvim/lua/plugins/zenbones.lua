require("utils")

return {
  "mcchrish/zenbones.nvim",
  config = function()
    vim.g.zenbones_compat = 1

    local mode = Utils:read_file("/tmp/dark-mode")

    if string.find(mode, "dark") then
      vim.opt.background = "dark"
    else
      vim.opt.background = "light"
    end

    vim.cmd("colorscheme zenbones")
  end,
}
