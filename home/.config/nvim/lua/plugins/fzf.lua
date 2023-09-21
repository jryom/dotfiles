return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<space>b", ":FzfLua buffers<cr>", desc = "Buffers", silent = true },
    { "<space>f", ":FzfLua blines<cr>", desc = "Search in file", silent = true },
    { "<space>h", ":FzfLua help_tags<cr>", desc = "Help", silent = true },
    { "<space>o", ":FzfLua files<cr>", desc = "Open file", silent = true },
    {
      "<space>i",
      function()
        require("fzf-lua").grep({ search = "", fzf_opts = { ["--nth"] = "2..", ["--delimiter"] = ":" } })
      end,
      desc = "Search in project",
      silent = true,
    },
    {
      "<space>i",
      "<cmd>FzfLua grep_visual<cr>",
      desc = "Search selection in project",
      mode = "x",
      silent = true,
    },
  },
  opts = {
    keymap = {
      builtin = {
        ["<C-u>"] = "preview-page-up",
        ["<C-d>"] = "preview-page-down",
      },
    },
    files = {
      fzf_opts = {
        ["--history"] = vim.fn.expand("~/.local/share/nvim") .. "/" .. "fzf_files_history",
        ["--scheme"] = "path",
      },
    },
    grep = {
      fzf_opts = {
        ["--history"] = vim.fn.expand("~/.local/share/nvim") .. "/" .. "fzf_grep_history",
      },
      no_header = true,
    },
    helptags = {
      actions = {
        ["default"] = function()
          (require("fzf-lua.actions")).help_vert()
        end,
      },
    },
  },
}
