return function()
  require("lualine").setup({
    options = {
      component_separators = { left = "|", right = "" },
      icons_enabled = false,
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_b = {
        "branch",
        "diff",
      },
      lualine_c = { "filename" },
      lualine_x = { "g:coc_status" },
      lualine_y = { { "filetype", colored = false } },
      lualine_z = {
        "%l/%L:%-2.c",
        {
          "diagnostics",
          diagnostics_color = {
            error = "DiagnosticVirtualTextError",
            warn = "DiagnosticVirtualTextWarn",
            info = "DiagnosticVirtualTextInfo",
            hint = "DiagnosticVirtualTextHint",
          },
          symbols = { error = "", warn = "", info = "", hint = "" },
        },
      },
    },
  })
end
