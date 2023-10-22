return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "b0o/incline.nvim",
    opts = {
      window = {
        options = {
          winblend = 30,
        },
      },
      hide = { cursorline = "focused_win" },
      ignore = {
        filetypes = { "oil" },
      },
      render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local res = bufname ~= "" and vim.fn.fnamemodify(bufname, ":.") or "[No Name]"
        if vim.api.nvim_buf_get_option(props.buf, "modified") then
          res = res .. " [+]"
        end
        return res
      end,
    },
  },
  opts = {
    options = {
      globalstatus = true,
      component_separators = { left = "|", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
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
          symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
        },
      },
    },
  },
}
