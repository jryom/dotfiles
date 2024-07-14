---@type LazySpec
return {
  "akinsho/bufferline.nvim",
  event = { "TabNew", "TabEnter", "TabEnter" },
  config = function()
    require("bufferline").setup({
      options = {
        always_show_bufferline = false,
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_duplicate_prefix = false,
      },
    })
  end,
}
