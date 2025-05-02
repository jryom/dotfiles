---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  cmd = "FzfLua",
  keys = {
    { "<D-b>", function() require("fzf-lua").buffers() end, desc = "Buffers", silent = true },
    { "<D-i>", function() require("fzf-lua").blines() end, desc = "Buffer lines", silent = true, mode = { "n", "x" } },
    { "?", function() require("fzf-lua").helptags() end, desc = "Help", silent = true },
    { "<D-o>", function() require("fzf-lua").files() end, desc = "Open file", silent = true },
    {
      "<D-f>",
      function() require("fzf-lua").grep_project() end,
      desc = "Fuzzy grep",
      silent = true,
    },
    {
      "<D-g>",
      function() require("fzf-lua").live_grep() end,
      desc = "Live grep",
      silent = true,
    },
    {
      "<D-f>",
      function() require("fzf-lua").grep_visual() end,
      desc = "Search selection in project",
      mode = "x",
      silent = true,
    },
  },
  init = function() require("which-key").add({ "<D>", group = "Fzf" }) end,
  config = function()
    require("fzf-lua").setup({
      previewers = { builtin = { snacks_image = { enabled = false } } },
      fzf_colors = true,
      "telescope",
      defaults = {
        file_icons = false,
      },
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
          ["<C-q>"] = "select-all+accept",
        },
      },
      grep = {
        RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
        rg_glob = true,
        fzf_opts = {
          ["--history"] = vim.fn.expand("~/.local/share/nvim") .. "/" .. "fzf_grep_history",
        },
        no_header = true,
      },
    })
  end,
}
