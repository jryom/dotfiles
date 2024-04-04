local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Up"))
  vim.keymap.set("n", "l", function()
    api.node.open.edit()
  end, opts("Open"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  keys = {
    { "<space>t", ":NvimTreeFindFileToggle<cr>", desc = "Toggle tree", silent = true },
  },
  cmd = { "NvimTreeOpen" },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    local width = vim.api.nvim_get_option("columns")
    if width > 250 and vim.bo.filetype ~= "gitcommit" then
      vim.cmd("NvimTreeOpen")
    else
      vim.cmd("NvimTreeClose")
    end
  end,
  opts = {
    on_attach = my_on_attach,
    hijack_cursor = true,
    hijack_netrw = false,
    sync_root_with_cwd = true,
    select_prompts = true,
    view = {
      width = {
        min = 30,
        max = 60,
      },
    },
    renderer = {
      special_files = {},
      highlight_opened_files = "all",
      icons = {
        web_devicons = {
          file = { enable = false },
          folder = { enable = false },
        },
        show = {
          file = false,
          folder = false,
          folder_arrow = false,
          git = false,
          modified = false,
          diagnostics = false,
          bookmarks = false,
        },
      },
    },
    update_focused_file = { enable = true },
    trash = { cmd = "trash" },
  },
}
