return {
  "akinsho/bufferline.nvim",
  event = { "TabNew", "TabEnter", "TabEnter" },
  opts = {
    options = {
      always_show_bufferline = false,
      mode = "tabs",
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_duplicate_prefix = false,
    },
  },
}
