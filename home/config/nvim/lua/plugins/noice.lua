---@type LazySpec
return {
  "folke/noice.nvim",
  version = "*",
  dependencies = "muniftanjim/nui.nvim",
  event = "VeryLazy",
  config = function()
    require("noice").setup({
      presets = {
        bottom_search = true,
        long_message_to_split = true,
        command_palette = true,
        lsp_doc_border = true,
      },
      popupmenu = { backend = "cmp" },
      cmdline = {
        format = {
          cmdline = { icon = "", title = "" },
          search_down = { kind = "search", pattern = "", icon = "", lang = "regex" },
          filter = false,
          lua = false,
          help = false,
        },
      },
    })
  end,
}
