return {
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
}
