return {
  {
    "mcchrish/zenbones.nvim",
    config = function()
      local isDarkMode = string.match(vim.fn.system("defaults read -g AppleInterfaceStyle"), "Dark")
        == "Dark"
      vim.cmd(isDarkMode and "colo zenflesh" or "color zenbones")
    end,
  },

  {
    "cormacrelf/dark-notify",
    event = "CursorHold",
    config = function()
      require("dark_notify").run({
        onchange = function(mode)
          vim.cmd([[
            highlight! link       CocErrorHighlight     DiagnosticUnderlineError
            highlight! link       CocHintHighlight      DiagnosticUnderlineHint
            highlight! link       CocInfoHighlight      DiagnosticUnderlineInfo
            highlight! link       CocWarningHighlight   DiagnosticUnderlineWarn
            highlight! link       CocErrorVirtualText   DiagnosticError
            highlight! link       CocHintVirtualText    DiagnosticHint
            highlight! link       CocInfoVirtualText    DiagnosticInformation
            highlight! link       CocWarningVirtualText DiagnosticWarn
          ]])
          if vim.g.colors_name == nil then
            vim.cmd(mode == "dark" and "colo zenflesh" or "colo zenbones")
          end
        end,
      })
    end,
  },
}
