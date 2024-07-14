require("utils")

---@type LazySpec[]
return {
  {
    "mcchrish/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      local mode = Utils:read_file("/tmp/dark-mode")

      if type(mode) == "string" and string.find(mode, "dark") then
        vim.opt.background = "dark"
      else
        vim.opt.background = "light"
      end

      vim.cmd("colorscheme zenbones")
    end,
  },

  {
    "cormacrelf/dark-notify",
    event = "VeryLazy",
    config = function() require("dark_notify").run() end,
  },
}
