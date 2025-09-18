local cwd = function()
  local cwd = vim.uv.cwd()
  local home = os.getenv("HOME")

  if cwd and home then
    return cwd:gsub(home, "~"):gsub("~/Code/", "")
  else
    return ""
  end
end

local macro_rec = function() return vim.fn.reg_recording() end

local hideBelow = function(columns)
  return function() return vim.o.columns > columns end
end

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local utils = require("lualine.utils.utils")
    require("lualine").setup({
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          { cwd, cond = hideBelow(100) },
        },
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
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = {
              fg = utils.extract_color_from_hllist({ "fg" }, { "DiagnosticInfo" }, "#ffffff"),
            },
          },
        },
        lualine_y = { { "filetype", icons_enabled = false, cond = hideBelow(150) } },
        lualine_z = { { "%l/%L", cond = hideBelow(80) } },
      },
    })
  end,
}
