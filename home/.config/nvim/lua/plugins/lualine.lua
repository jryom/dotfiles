return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        component_separators = { left = "|", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return vim.fn.winwidth(0) < 120 and str:sub(1, 1) or str
            end,
          },
        },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            newfile_status = true,
            path = 1,
          },
        },
        lualine_x = {},
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
  end,
}
