return {
  "mg979/vim-visual-multi",
  keys = {
    "<C-j>",
    "<C-k>",
    "<C-n>",
  },
  init = function()
    vim.g.VM_highlight_matches = "underline"
    vim.g.VM_Mono_hl = "DiffText"
    vim.g.VM_maps = {
      ["Add Cursor Down"] = "<C-j>",
      ["Add Cursor Up"] = "<C-k>",
    }
  end,
}
