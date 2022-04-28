return function()
  require("lualine").setup({
    options = {
      icons_enabled = false,
      section_separators = { left = "", right = "" },
      component_separators = { left = "|", right = "" },
      disabled_filetypes = {},
    },
    sections = {
      lualine_b = {
        "branch",
        "diff",
      },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "g:coc_status" },
      lualine_y = { "filetype" },
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
