return {
  "lewis6991/gitsigns.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    {
      "<space>gb",
      ":Gitsigns blame_line<CR>",
      desc = "Blame line",
      silent = true,
    },
    {
      "yog",
      ":Gitsigns toggle_current_line_blame<CR>",
      desc = "Toggle current line blame",
      silent = true,
    },
    {
      "<space>gr",
      ":Gitsigns reset_hunk<CR>",
      desc = "Reset hunk",
      silent = true,
      mode = { "x", "n" },
    },
    {
      "<space>gR",
      ":Gitsigns reset_buffer<CR>",
      desc = "Reset buffer",
      silent = true,
      mode = { "x", "n" },
    },
    {
      "<space>gn",
      ":Gitsigns next_hunk<CR>",
      desc = "Next hunk",
      silent = true,
    },
    {
      "<space>gp",
      ":Gitsigns prev_hunk<CR>",
      desc = "Prev hunk",
      silent = true,
    },
  },
  init = function() require("which-key").add({ "<space>g", group = "Git" }) end,
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "✳" },
      },
    })
  end,
}
