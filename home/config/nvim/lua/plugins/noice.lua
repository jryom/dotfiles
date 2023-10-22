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
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
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
      long_message_to_split = true,
      command_palette = true,
      lsp_doc_border = true,
      inc_rename = true,
    },
    cmdline = {
      format = {
        cmdline = { icon = "" },
        search_down = { icon = "" },
        filter = { icon = "" },
        lua = { icon = "" },
        help = { icon = "" },
      },
    },
  },
}
