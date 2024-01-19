return {
  {
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
  },

  {
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
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    event = "VeryLazy",
    keys = {
      { "-", ":Oil<CR>", desc = "File browser", silent = true },
      { "<C-h>", ":Oil<CR>", desc = "File browser", silent = true },
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      win_options = {
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },
      keymaps = {
        ["q"] = "actions.close",
        ["<C-l>"] = "actions.select",
        ["<C-h>"] = "actions.parent",
        ["<C-k>"] = "k",
        ["<C-j>"] = "j",
      },
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          return name == ".."
        end,
      },
    },
  },

  {
    "chrishrb/gx.nvim",
    event = { "VeryLazy" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
