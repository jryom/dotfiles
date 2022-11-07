return function()
  local actions = require("lir.actions")
  local clipboard_actions = require("lir.clipboard.actions")
  local mark_actions = require("lir.mark.actions")

  vim.cmd([[
    highlight def link LirSymLink Comment
    highlight def link LirEmptyDirText Comment
  ]])

  require("lir").setup({
    show_hidden_files = true,
    devicons_enable = false,
    mappings = {
      ["l"] = actions.edit,
      ["h"] = actions.up,
      ["<C-s>"] = actions.split,
      ["<C-v>"] = actions.vsplit,
      ["<C-t>"] = actions.tabedit,
      ["q"] = actions.quit,
      ["d"] = actions.mkdir,
      ["n"] = actions.touch,
      ["r"] = actions.rename,
      ["Y"] = actions.yank_path,
      ["D"] = actions.delete,
      ["å"] = mark_actions.mark,
      ["m"] = mark_actions.mark,
      ["c"] = mark_actions.unmark,
      ["<c-C>"] = clipboard_actions.copy,
      ["<c-X>"] = clipboard_actions.cut,
      ["<c-P>"] = clipboard_actions.paste,
    },
    hide_cursor = true,
    on_init = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end,
  })
end
