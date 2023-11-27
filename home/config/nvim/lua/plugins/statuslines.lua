local cwd = function()
  local cwd = vim.loop.cwd()
  local home = os.getenv("HOME")

  return cwd:gsub(home, "~"):gsub("~/Code/", "")
end

return {

  {
    "b0o/incline.nvim",
    opts = {},
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { cwd },
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          {
            "diagnostics",
            diagnostics_color = {
              error = "DiagnosticVirtualTextError",
              warn = "DiagnosticVirtualTextWarn",
              info = "DiagnosticVirtualTextInfo",
              hint = "DiagnosticVirtualTextHint",
            },
            symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
          },
        },
        lualine_y = { "filetype" },
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
        numbers = "ordinal",
        show_buffer_close_icons = false,
      },
    },
  },
}
