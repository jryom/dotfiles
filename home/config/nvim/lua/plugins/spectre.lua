return {
  "nvim-pack/nvim-spectre",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    {
      "<space>s",
      ":lua require('spectre').open_visual({select_word = true})<CR>",
      desc = "Find and replace",
      silent = true,
    },
    {
      "<space>s",
      '"vy :lua require("spectre").open({ is_insert_mode=false,search_text=vim.fn.getreg("v") })<CR>',
      desc = "Find and replace",
      silent = true,
      mode = "x",
    },
  },
  opts = {
    color_devicons = false,
    line_sep_start = "",
    result_padding = "",
    line_sep = "",
    live_update = true,
    is_insert_mode = true,
    mapping = {
      ["send_to_qf"] = {
        map = "q",
        cmd = ":lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix",
      },
      ["show_option_menu"] = {
        map = "go",
        cmd = ":lua require('spectre').show_options()<CR>",
        desc = "show option",
      },
      ["run_current_replace"] = {
        map = "r",
        cmd = ":lua require('spectre.actions').run_current_replace()<CR>",
        desc = "replace current line",
      },
      ["run_replace"] = {
        map = "R",
        cmd = ":lua require('spectre.actions').run_replace()<CR>",
        desc = "replace all",
      },
      ["change_view_mode"] = {
        map = "gv",
        cmd = ":lua require('spectre').change_view()<CR>",
        desc = "change result view mode",
      },
      ["toggle_ignore_case"] = {
        map = "ti",
        cmd = ":lua require('spectre').change_options('ignore-case')<CR>",
        desc = "toggle ignore case",
      },
      ["toggle_ignore_hidden"] = {
        map = "th",
        cmd = ":lua require('spectre').change_options('hidden')<CR>",
        desc = "toggle search hidden",
      },
    },
  },
}
