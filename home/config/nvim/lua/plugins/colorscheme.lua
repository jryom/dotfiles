---@diagnostic disable: undefined-global
local overwrite = function()
  local lush = require("lush")

  local specs = lush.parse(
    function()
      return {
        LspReferenceText({ gui = "underline" }),
        LspReferenceRead({ gui = "underline" }),
        LspReferenceWrite({ gui = "underline" }),
        DapUINormal({ link = "Normal" }),
        DapUIVariable({ link = "Normal" }),
        DapUIScope({ link = "Constant" }),
        DapUIType({ link = "Type" }),
        DapUIValue({ link = "Normal" }),
        DapUIModifiedValue({ link = "Statement", gui = "bold" }),
        DapUIDecoration({ link = "Special" }),
        DapUIThread({ link = "String" }),
        DapUIStoppedThread({ link = "Error" }),
        DapUIFrameName({ link = "Normal" }),
        DapUISource({ link = "Type" }),
        DapUILineNumber({ link = "LineNr" }),
        DapUIFloatNormal({ link = "NormalFloat" }),
        DapUIFloatBorder({ link = "FloatBorder" }),
        DapUIWatchesEmpty({ link = "Error" }),
        DapUIWatchesValue({ link = "String" }),
        DapUIWatchesError({ link = "Error" }),
        DapUIBreakpointsPath({ link = "Directory" }),
        DapUIBreakpointsInfo({ link = "String" }),
        DapUIBreakpointsCurrentLine({ link = "CursorLineNr", gui = "bold" }),
        DapUIBreakpointsLine({ link = "LineNr" }),
        DapUIBreakpointsDisabledLine({ link = "Comment" }),
        DapUICurrentFrameName({ link = "CursorLineNr" }),
        DapUIStepOver({ link = "Function" }),
        DapUIStepInto({ link = "Function" }),
        DapUIStepBack({ link = "Function" }),
        DapUIStepOut({ link = "Function" }),
        DapUIStop({ link = "Error" }),
        DapUIPlayPause({ link = "String" }),
        DapUIRestart({ link = "String" }),
        DapUIUnavailable({ link = "Comment" }),
        DapUIWinSelect({ link = "WildMenu" }),
        DapUIEndofBuffer({ link = "EndOfBuffer" }),
      }
    end
  )

  lush.apply(lush.compile(specs))
end

---@type LazySpec[]
return {
  {
    "mcchrish/zenbones.nvim",
    version = "*",
    priority = 1000,
    dependencies = "rktjmp/lush.nvim",
    config = function()
      local mode = nil
      if vim.fn.filereadable("/tmp/dark-mode") == 1 then
        mode = vim.fn.readfile("/tmp/dark-mode")[1]
      end

      vim.g.zenbones_darken_noncurrent_window = true
      vim.g.zenbones_lighten_noncurrent_window = true
      vim.g.zenbones_darken_line_nr = 15
      vim.g.zenbones_lighten_line_nr = 15

      if type(mode) == "string" and string.find(mode, "dark") then
        vim.opt.background = "dark"
      else
        vim.opt.background = "light"
      end

      vim.cmd("colorscheme zenbones")
      overwrite()

      vim.cmd([[
        highlight! link DapUIModifiedValue Statement
        highlight! link DapUIBreakpointsCurrentLine CursorLineNr
        highlight! link DapUIPlayPause String
        highlight! link DapUIRestart String
        highlight! link DapUIStop Error
        highlight! link DapUIUnavailable Comment
        highlight! link DapUIStepOver Function
        highlight! link DapUIStepInto Function
        highlight! link DapUIStepBack Function
        highlight! link DapUIStepOut Function
        highlight! link DapUIScope Constant
        highlight! link DapUIType Type
        highlight! link DapUIDecoration Special
        highlight! link DapUIThread String
        highlight! link DapUIStoppedThread Error
        highlight! link DapUISource Type
        highlight! link DapUILineNumber LineNr
        highlight! link DapUIFloatBorder FloatBorder
        highlight! link DapUIWatchesEmpty Error
        highlight! link DapUIWatchesValue String
        highlight! link DapUIWatchesError Error
        highlight! link DapUIBreakpointsPath Directory
        highlight! link DapUIBreakpointsInfo String
        highlight! TabLineSel guibg=bg
      ]])
    end,
  },

  {
    "cormacrelf/dark-notify",
    event = "VeryLazy",
    config = function()
      require("dark_notify").run({
        onchange = overwrite,
      })
    end,
  },
}
