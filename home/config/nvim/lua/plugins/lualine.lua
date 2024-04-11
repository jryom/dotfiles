local cwd = function()
  local cwd = vim.loop.cwd()
  local home = os.getenv("HOME")

  return cwd:gsub(home, "~"):gsub("~/Code/", "")
end

local lsp_clients = function()
  local buf_clients = vim.lsp.buf_get_clients()
  local buf_client_names = {}
  for _, client in pairs(buf_clients) do
    local client_name = client.name:match("^[^%W_]+")
    table.insert(buf_client_names, client_name)
  end
  return table.concat(buf_client_names, ", ")
end

local macro_rec = function()
  return vim.fn.reg_recording()
end

local treesitter = function()
  if
    vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil and vim.api.nvim_win_get_width(0) > 120
  then
    return vim.bo.filetype .. " (ts)"
  end
  return vim.bo.filetype
end

local hideBelow = function(columns)
  return function()
    return vim.api.nvim_win_get_width(0) > columns
  end
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { { cwd, cond = hideBelow(100) } },
      lualine_b = { { "branch", cond = hideBelow(140) } },
      lualine_c = { { "filename", path = 1, shorting_target = 5 }, macro_rec },
      lualine_x = { { lsp_clients, cond = hideBelow(150) } },
      lualine_y = { { treesitter, cond = hideBelow(80) } },
      lualine_z = { { "%l/%L", cond = hideBelow(80) } },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1, shorting_target = 5 } },
      lualine_x = { { "%l/%L", cond = hideBelow(80) } },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
