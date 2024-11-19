---@diagnostic disable: undefined-global
require("utils")

local overwrite = function()
  local lush = require("lush")

  local specs = lush.parse(
    function()
      return {
        LspReferenceText({ gui = "underline" }),
        LspReferenceRead({ gui = "underline" }),
        LspReferenceWrite({ gui = "underline" }),
      }
    end
  )

  lush.apply(lush.compile(specs))
end

---@type LazySpec[]
return {
  {
    "mcchrish/zenbones.nvim",
    version = "*",
    priority = 1000,
    dependencies = "rktjmp/lush.nvim",
    config = function()
      local mode = Utils:read_file("/tmp/dark-mode")

      vim.g.zenbones_darken_noncurrent_window = true
      vim.g.zenbones_lighten_noncurrent_window = true
      vim.g.zenbones_darken_line_nr = 15
      vim.g.zenbones_lighten_line_nr = 15

      if type(mode) == "string" and string.find(mode, "dark") then
        vim.opt.background = "dark"
      else
        vim.opt.background = "light"
      end

      vim.cmd("colorscheme zenbones")
      overwrite()
    end,
  },

  {
    "cormacrelf/dark-notify",
    event = "VeryLazy",
    config = function()
      require("dark_notify").run({
        onchange = overwrite,
      })
    end,
  },
}
