return function()
  require("spectre").setup({
    color_devicons = false,
    line_sep_start = "",
    result_padding = "",
    line_sep = "",
    live_update = true,
    is_insert_mode = true,
    mapping = {
      ["send_to_qf"] = {
        map = "q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix",
      },
      ["show_option_menu"] = {
        map = "go",
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = "show option",
      },
      ["run_current_replace"] = {
        map = "r",
        cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
        desc = "replace current line",
      },
      ["run_replace"] = {
        map = "R",
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = "replace all",
      },
      ["change_view_mode"] = {
        map = "gv",
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = "change result view mode",
      },
      ["toggle_ignore_case"] = {
        map = "ti",
        cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
        desc = "toggle ignore case",
      },
      ["toggle_ignore_hidden"] = {
        map = "th",
        cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
        desc = "toggle search hidden",
      },
    },
  })
end
