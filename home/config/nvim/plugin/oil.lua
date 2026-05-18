vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
  watch_for_changes = true,
  default_file_explorer = true,
  delete_to_trash = true,
  columns = {},
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
      local alwaysHidden = { "..", ".DS_Store" }
      for _, value in ipairs(alwaysHidden) do
        if name == value then return true end
      end
      return false
    end,
  },
})

vim.keymap.set("n", "-", ":Oil<CR>", { desc = "File browser", silent = true })
vim.keymap.set("n", "<C-h>", ":Oil<CR>", { desc = "File browser", silent = true })
