return {
  "folke/noice.nvim",
  dependencies = "muniftanjim/nui.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = { find = "written" },
        opts = { skip = true },
      },
      {
        filter = { find = "diagnostics_on_save" },
        opts = { skip = true },
      },
      {
        filter = { find = "diagnostics_on_open" },
        opts = { skip = true },
      },
    },
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
  },
}
