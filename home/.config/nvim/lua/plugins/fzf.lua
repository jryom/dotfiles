return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  config = function()
    local history_dir = vim.fn.expand("~/.local/share/nvim")
    local actions = require("fzf-lua.actions")
    require("fzf-lua").setup({
      keymap = {
        builtin = {
          ["<C-u>"] = "preview-page-up",
          ["<C-d>"] = "preview-page-down",
        },
      },
      files = {
        fzf_opts = {
          ["--history"] = history_dir .. "/" .. "fzf_files_history",
          ["--scheme"] = "path",
        },
      },
      grep = {
        fzf_opts = {
          ["--history"] = history_dir .. "/" .. "fzf_grep_history",
        },
        no_header = true,
      },
      helptags = {
        actions = {
          ["default"] = actions.help_vert,
        },
      },
    })
  end,
}
