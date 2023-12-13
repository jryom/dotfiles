return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<space>gb",
        ":Gitsigns blame_line<CR>",
        desc = "Blame line",
        silent = true,
      },
      {
        "<space>gt",
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
    opts = { current_line_blame_formatter_opts = { relative_time = true }, current_line_blame = true },
  },

  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<space>gd",
        ":DiffviewOpen<cr>",
        desc = "Diff",
        silent = true,
      },
      {
        "<space>gh",
        ":DiffviewFileHistory %<cr>",
        desc = "File history",
        silent = true,
      },
    },
    opts = {
      file_panel = {
        listing_style = "list",
      },
      show_help_hints = false,
    },
  },

  {
    "linrongbin16/gitlinker.nvim",
    keys = {
      {
        "<space>gl",
        ":GitLink<CR>",
        desc = "Copy git permlink to clipboard",
        silent = true,
        mode = { "x", "n" },
      },
      {
        "<space>gL",
        ":GitLink!<CR>",
        desc = "Open git permlink in browser",
        silent = true,
        mode = { "x", "n" },
      },
    },
    opts = {},
  },
}
