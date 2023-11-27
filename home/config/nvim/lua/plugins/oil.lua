return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "-", ":Oil<CR>", desc = "File browser", silent = true },
  },
  opts = {
    delete_to_trash = true,
    win_options = {
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    keymaps = {
      ["?"] = "actions.show_help",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["q"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["g."] = "actions.toggle_hidden",
      ["l"] = "actions.select",
      ["h"] = "actions.parent",
    },
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name)
        local excluded_names = { "%.meta", "%.csproj", "%.sln", "%.asmdef", ".vscode", ".DS_Store" }

        for _, pattern in ipairs(excluded_names) do
          if string.match(name, pattern) then
            return true
          end
        end
      end,
    },
  },
}
