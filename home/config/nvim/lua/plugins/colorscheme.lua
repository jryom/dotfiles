return {
  {
    "mcchrish/zenbones.nvim",
    version = "*",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenbones_compat = 1
      vim.cmd("colorscheme zenbones")

      vim.cmd([[
        highlight LspReferenceText gui=underline
        highlight LspReferenceRead gui=underline
        highlight LspReferenceWrite gui=underline
        highlight! TabLineSel guibg=bg
      ]])
    end,
  },
}
