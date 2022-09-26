return function()
  require("nvim-autopairs").setup({
    disable_in_macro = true,
    disable_in_visualblock = false, -- disable when insert after visual block mode
    enable_moveright = false,
    enable_afterquote = true, -- add bracket pairs after quote
    enable_check_bracket_line = true, --- check bracket in same line
    enable_bracket_in_quote = true,
    break_undo = true,
    check_ts = true,
  })
end
