return function()
  vim.g.indent_blankline_char = "▏"
  vim.g.indent_blankline_filetype_exclude = { "help", "markdown", "man" }
  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_use_treesitter = true
end
