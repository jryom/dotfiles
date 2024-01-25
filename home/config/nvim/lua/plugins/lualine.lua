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
  if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil then
    return vim.bo.filetype .. " (ts)"
  end
  return vim.bo.filetype
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { cwd },
      lualine_b = { "branch" },
      lualine_c = { { "filename", path = 1 }, macro_rec },
      lualine_x = { lsp_clients },
      lualine_y = { treesitter },
      lualine_z = { "%l/%L" },
    },
  },
}
