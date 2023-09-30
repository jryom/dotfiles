return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
  keys = function()
    local function fuzzyGrep()
      require("telescope.builtin").grep_string({
        path_display = { "smart" },
        only_sort_text = true,
        word_match = "-w",
        search = "",
        theme = "dropdown",
      })
    end

    return {
      { "<space>b", ":Telescope buffers<cr>", desc = "Buffers", silent = true },
      { "<space>f", ":Telescope current_buffer_fuzzy_find<cr>", desc = "Search in file", silent = true },
      { "<space>h", ":Telescope help_tags<cr>", desc = "Help", silent = true },
      { "<space>o", ":Telescope find_files<cr>", desc = "Open file", silent = true },
      { "<space>i", fuzzyGrep, desc = "Search", silent = true, mode = "n" },
      {
        "<space>i",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "Search selection",
        silent = true,
        mode = "x",
      },
    }
  end,
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      pickers = {
        grep_string = {
          previewer = false,
          theme = "dropdown",
          layout_config = {
            width = 0.5,
          },
        },
        find_files = {
          previewer = false,
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
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
        winblend = 8,
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
  end,
}
