return {
  "lukas-reineke/indent-blankline.nvim",
  event = "ColorScheme",
  opts = {
    context_char = "▏",
    char = "▏",
    filetype_exclude = { "help", "markdown", "man", "trouble", "lazy" },
    show_end_of_line = true,
    show_current_context = true,
    show_trailing_blankline_indent = false,
    use_treesitter = true,
  },
}
