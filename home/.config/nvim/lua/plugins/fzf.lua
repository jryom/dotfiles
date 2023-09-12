return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  config = function()
    local history_dir = vim.fn.expand("~/.local/share/nvim")
    require("fzf-lua").setup({
      winopts = {
        hl = {
          scrollborder_f = "NonText",
        },
      },
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
    })
  end,
}
