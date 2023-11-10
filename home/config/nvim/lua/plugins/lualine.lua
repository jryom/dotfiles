local function isWiderThan(cols)
  return function()
    return vim.fn.winwidth(0) > cols
  end
end

local cwd = function()
  local cwd = vim.loop.cwd()
  local home = os.getenv("HOME")

  return cwd:gsub(home, "~"):gsub("~/Code/", "")
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    inactive_sections = {
      lualine_a = { { cwd, cond = isWiderThan(120) } },
      lualine_c = { { "filename", shorting_target = 10, path = 1 } },
      lualine_x = {},
    },
    sections = {
      lualine_a = { { cwd, cond = isWiderThan(120) } },
      lualine_b = {},
      lualine_c = { { "filename", shorting_target = 10, path = 1 } },
      lualine_x = { { "diagnostics", symbols = { error = "E", warn = "W", info = "I", hint = "H" } } },
      lualine_y = { {
        "filetype",
        cond = isWiderThan(140),
      } },
      lualine_z = { { "%l/%L", cond = isWiderThan(90) } },
    },
  },
}
