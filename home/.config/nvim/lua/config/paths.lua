local M = {}

local code_home = vim.env.CODE_HOME and vim.env.CODE_HOME ~= "" and vim.env.CODE_HOME or vim.env.HOME .. "/Code"

function M.short_cwd()
  local cwd = vim.uv.cwd()
  if not cwd then return "" end
  if vim.startswith(cwd, code_home .. "/") then return cwd:sub(#code_home + 2) end
  return cwd:gsub("^" .. vim.pesc(vim.env.HOME), "~")
end

return M
