return function()
  local hydra = require("hydra.statusline")
  local lualine = require("lualine")

  lualine.setup({
    options = {
      component_separators = { left = "|", right = "" },
      icons_enabled = false,
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        { "mode", cond = function() return not hydra.is_active() end },
        { hydra.get_name, cond = hydra.is_active, color = "lualine_a_replace" },
      },
      lualine_b = {
        "branch",
        "diff",
      },
      lualine_c = {
        {
          "filename",
          newfile_status = true,
          path = 1,
          symbols = {
            modified = " ",
            readonly = " ",
            unnamed = " ",
          },
        },
      },
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
