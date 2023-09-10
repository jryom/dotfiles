return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      break_undo = true,
      check_ts = true,
      disable_in_macro = true,
      disable_in_visualblock = false,
      enable_afterquote = true,
      enable_bracket_in_quote = true,
      enable_check_bracket_line = true,
      enable_moveright = false,
    })
  end,
}
