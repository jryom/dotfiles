return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  keys = {
    {
      "<space>i",
      ":FzfLua grep_project<cr>",
      desc = "Fuzzy grep",
      silent = true,
    },
    {
      "<space>I",
      ":FzfLua live_grep<cr>",
      desc = "Live grep",
      silent = true,
    },
    {
      "<space>i",
      function()
        require("fzf-lua").grep_visual()
      end,
      desc = "Search selection in project",
      mode = "x",
      silent = true,
    },
  },
  opts = {
    "telescope",
    winopts = { preview = { hidden = "hidden" } },
    keymap = {
      builtin = {
        ["<C-u>"] = "preview-page-up",
        ["<C-d>"] = "preview-page-down",
      },
    },
    grep = {
      fzf_opts = {
        ["--history"] = vim.fn.expand("~/.local/share/nvim") .. "/" .. "fzf_grep_history",
      },
      no_header = true,
    },
  },
}
