return {
  "folke/noice.nvim",
  dependencies = "muniftanjim/nui.nvim",
  event = "VeryLazy",
  keys = { { "<space>M", ":Noice telescope<cr>", desc = "Messages", silent = true } },
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
      long_message_to_split = true,
      command_palette = true,
      lsp_doc_border = true,
    },
    popupmenu = { backend = "cmp" },
    cmdline = {
      format = {
        command = { pattern = "^:", icon = "", lang = "vim", title = "" },
        search_down = false,
        search_up = false,
        filter = false,
        lua = false,
        help = false,
      },
    },
  },
}
