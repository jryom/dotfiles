vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local cwd = function()
  local dir = vim.uv.cwd()
  local home = os.getenv("HOME")
  if dir and home then
    return dir:gsub(home, "~"):gsub("~/Code/", "")
  end
  return ""
end

local macro_rec = function() return vim.fn.reg_recording() end

local hideBelow = function(columns)
  return function() return vim.o.columns > columns end
end

require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { { cwd, cond = hideBelow(100) } },
    lualine_b = { { "branch", cond = hideBelow(200) } },
    lualine_c = {
      { "filename", path = 1, shorting_target = 5 },
      macro_rec,
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic", "nvim_workspace_diagnostic" },
        cond = hideBelow(150),
      },
      { "lsp_status", icon = "", cond = hideBelow(200) },
    },
    lualine_y = { { "filetype", icons_enabled = false, cond = hideBelow(150) } },
    lualine_z = { { "%l/%L", cond = hideBelow(80) } },
  },
})
