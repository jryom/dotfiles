return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")
    local fg = function(name)
      local hl = vim.api.nvim_get_hl_by_name(name, true)
      return "#" .. hl.foreground
    end

    lualine.setup({
      options = {
        component_separators = { left = "|", right = "" },
        globalstatus = true,
        icons_enabled = false,
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
        lualine_b = {
          "branch",
          "diff",
        },
        lualine_c = {
          {
            "filename",
            newfile_status = true,
            path = 1,
          },
        },
        lualine_x = {
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = fg("DiagnosticWarn") },
          },
          {
            require("noice").api.status.search.get,
            cond = require("noice").api.status.search.has,
            color = { fg = fg("DiagnosticInfo") },
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = fg("DiagnosticHint") },
          },
        },
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
