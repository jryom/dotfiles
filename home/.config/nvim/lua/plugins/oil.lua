return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "-", ":Oil<CR>", desc = "File browser", silent = true },
  },
  opts = {
    delete_to_trash = true,
    trash_command = "trash",
    keymaps = {
      ["?"] = "actions.show_help",
      ["l"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["q"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["h"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["g."] = "actions.toggle_hidden",
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
        return false
      end,
    },
  },
}
