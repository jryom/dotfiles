return function()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      dynamic_preview_title = true,
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["K"] = actions.preview_scrolling_up,
          ["J"] = actions.preview_scrolling_down,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
        },
      },
      prompt_prefix = "",
      layout_config = {
        scroll_speed = 2,
        preview_cutoff = 200,
      },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files" },
        previewer = false,
        theme = "dropdown",
      },
      live_grep = {
        disable_coordinates = true,
        only_sort_text = true,
      },
      grep_string = {
        disable_coordinates = true,
      },
      buffers = {
        only_cwd = true,
        previewer = false,
        sort_mru = true,
        theme = "dropdown",
      },
    },
  })
end
