return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<space>b", ":FzfLua buffers<cr>", desc = "Buffers", silent = true },
    { "<space>f", ":FzfLua grep_curbuf<cr>", desc = "Search in buffer", silent = true },
    { "<space>h", ":FzfLua helptags<cr>", desc = "Help", silent = true },
    { "<space>o", ":FzfLua files<cr>", desc = "Open file", silent = true },
    { "<leader>d", ":FzfLua diagnostics_workspace<cr>", desc = "Diagnostics", silent = true },
    { "<leader>q", ":FzfLua quickfix<cr>", desc = "Quickfix", silent = true },
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
  config = function(_, opts)
    require("fzf-lua").setup(opts)
    vim.api.nvim_set_hl(0, "FzfLuaBufLineNr", { link = "LineNr" })
    vim.api.nvim_set_hl(0, "FzfLuaCursor", { link = "None" })
    vim.api.nvim_set_hl(0, "FzfLuaHeaderBind", { link = "Special" })
    vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { link = "Special" })
    vim.api.nvim_set_hl(0, "FzfLuaTabMarker", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "FzfLuaTabTitle", { link = "Title" })
    vim.api.nvim_set_hl(0, "FzfLuaBufFlagAlt", {})
    vim.api.nvim_set_hl(0, "FzfLuaBufFlagCur", {})
    vim.api.nvim_set_hl(0, "FzfLuaBufName", {})
    vim.api.nvim_set_hl(0, "FzfLuaBufNr", {})
  end,
  opts = {
    "telescope",
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
