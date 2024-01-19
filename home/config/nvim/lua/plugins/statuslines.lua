local function get_diagnostic_label(props)
  local icons = { Error = "E", Warn = "W" }
  local label = {}

  for severity, icon in pairs(icons) do
    local count = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
    if count > 0 then
      table.insert(label, { " " .. icon .. count .. " ", group = "DiagnosticVirtualText" .. severity })
    end
  end
  return label
end

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

  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    opts = {
      hide = { cursorline = "focused_win" },
      ignore = { filetypes = { "oil" } },
      window = { margin = { vertical = { top = 0, bottom = 0 } }, padding = 0 },
      render = function(props)
        local modified = vim.api.nvim_buf_get_option(props.buf, "modified")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

        local buffer = {
          { get_diagnostic_label(props), gui = "bold" },
          { " " },
          { filename, gui = modified and "bold,italic" or "" },
          { " " },
        }
        return buffer
      end,
    },
  },

  {
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
  },

  {
    "akinsho/bufferline.nvim",
    event = { "TabNew", "TabEnter", "TabEnter" },
    opts = {
      options = {
        always_show_bufferline = false,
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_duplicate_prefix = false,
      },
    },
  },
}
