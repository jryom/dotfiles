return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<D-b>", ":FzfLua buffers<cr>", desc = "Buffers", silent = true },
    { "<D-i>", ":FzfLua blines<cr>", desc = "Buffer lines", silent = true },
    { "?", ":FzfLua helptags<cr>", desc = "Help", silent = true },
    { "<D-o>", ":FzfLua files<cr>", desc = "Open file", silent = true },
    {
      "<D-f>",
      ":FzfLua grep_project<cr>",
      desc = "Fuzzy grep",
      silent = true,
    },
    {
      "<D-g>",
      ":FzfLua live_grep<cr>",
      desc = "Live grep",
      silent = true,
    },
    {
      "<D-f>",
      function()
        require("fzf-lua").grep_visual()
      end,
      desc = "Search selection in project",
      mode = "x",
      silent = true,
    },
  },
  opts = {
    fzf_colors = true,
    "telescope",
    winopts = {
      preview = {
        flip_columns = 300,
        vertical = "up:40%",
        horizontal = "right:40%",
      },
    },
    keymap = {
      builtin = {
        ["<C-u>"] = "preview-page-up",
        ["<C-d>"] = "preview-page-down",
      },
    },
    grep = {
      RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
      fzf_opts = {
        ["--history"] = vim.fn.expand("~/.local/share/nvim") .. "/" .. "fzf_grep_history",
      },
      no_header = true,
    },
  },
}
