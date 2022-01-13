return {
  "rktjmp/lush.nvim",
  "mcchrish/zenbones.nvim",

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
            highlight! link       ScrollView            PMenuSBar
          ]])
        end,
      })
    end,
  },
}
