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

return {
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
}
