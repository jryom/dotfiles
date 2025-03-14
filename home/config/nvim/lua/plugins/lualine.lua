local cwd = function()
  local cwd = vim.uv.cwd()
  local home = os.getenv("HOME")

  if cwd and home then
    return cwd:gsub(home, "~"):gsub("~/Code/", "")
  else
    return ""
  end
end

local lsp_clients = function()
  local buf_clients = vim.lsp.get_clients()
  local buf_client_names = {}
  for _, client in pairs(buf_clients) do
    local client_name = client.name:match("^[^%W_]+")
    if client_name ~= "GitHub" then table.insert(buf_client_names, client_name) end
  end
  return table.concat(buf_client_names, ", ")
end

local macro_rec = function() return vim.fn.reg_recording() end

local hideBelow = function(columns)
  return function() return vim.o.columns > columns end
end

---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local utils = require("lualine.utils.utils")
    require("lualine").setup({
      options = {
        icons_enabled = false,
        globalstatus = true,
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
          { lsp_clients, cond = hideBelow(200) },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = {
              fg = utils.extract_color_from_hllist({ "fg" }, { "DiagnosticInfo" }, "#ffffff"),
            },
          },
        },
        lualine_y = { { "filetype", cond = hideBelow(150) } },
        lualine_z = { { "%l/%L", cond = hideBelow(80) } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1, shorting_target = 5 } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
