return {
  "folke/noice.nvim",
  dependencies = "muniftanjim/nui.nvim",
  config = function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = false,
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
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "󱎸 ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "", icon = "" },
        },
      },
    })
  end,
}
