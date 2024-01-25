return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "debugloop/telescope-undo.nvim",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  event = "VeryLazy",
  keys = {
    { "<space>b", ":Telescope buffers<cr>", desc = "Buffers", silent = true },
    { "<space>f", ":Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer", silent = true },
    { "<space>h", ":Telescope help_tags<cr>", desc = "Help", silent = true },
    { "<space>o", ":Telescope find_files<cr>", desc = "Open file", silent = true },
    { "<leader>u", ":Telescope undo<cr>", desc = "Undo history", silent = true },
    { "<leader>d", ":Telescope diagnostics<cr>", desc = "Diagnostics", silent = true },
    { "<leader>q", ":Telescope quickfix<cr>", desc = "Quickfix", silent = true },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      pickers = {
        find_files = { previewer = false },
        buffers = {
          previewer = false,
          mappings = { i = { ["<c-d>"] = actions.delete_buffer } },
        },
        help_tags = {
          mappings = {
            i = {
              ["<cr>"] = actions.select_vertical,
            },
          },
        },
      },
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
        },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("undo")
  end,
}
