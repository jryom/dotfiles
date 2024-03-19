local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "h", api.node.navigate.parent, opts("Up"))
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<space>t", ":NvimTreeFindFileToggle<cr>", desc = "Toggle neotree", silent = true },
  },
  opts = {
    on_attach = my_on_attach,
    hijack_cursor = true,
    hijack_netrw = false,
    sync_root_with_cwd = true,
    select_prompts = true,
    view = {
      centralize_selection = false,
      width = {
        min = 30,
        max = 60,
      },
    },
    renderer = {
      root_folder_label = ":~:s?$?/..?",
      special_files = {},
      highlight_git = "all",
      highlight_diagnostics = "all",
      highlight_opened_files = "all",
      highlight_modified = "all",
      icons = {
        web_devicons = {
          file = { enable = false },
          folder = { enable = false },
        },
        git_placement = "after",
        padding = "",
        show = {
          file = false,
          folder = false,
        },
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "",
          modified = "m",
          git = {
            unstaged = "∗",
            staged = "+",
            renamed = "r",
            untracked = "∗",
            deleted = "-",
            ignored = "i",
          },
        },
      },
    },
    update_focused_file = { enable = true },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "H",
        info = "I",
        warning = "W",
        error = "E",
      },
    },
    modified = { enable = true },
    trash = { cmd = "trash" },
  },
}
