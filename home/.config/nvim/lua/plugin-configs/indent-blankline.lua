return function()
  require("indent_blankline").setup({
    char = "▏",
    filetype_exclude = { "help", "markdown", "man" },
    show_end_of_line = true,
    show_trailing_blankline_indent = false,
    use_treesitter = true,
  })
end
