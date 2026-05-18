vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

require("fzf-lua").setup({
  previewers = { builtin = { snacks_image = { enabled = false } } },
  fzf_colors = true,
  "telescope",
  defaults = { file_icons = false },
  winopts = {
    preview = {
      flip_columns = 300,
      vertical = "up:40%",
      horizontal = "right:40%",
    },
  },
  keymap = {
    builtin = {
      ["<C-u>"] = "preview-page-up",
      ["<C-d>"] = "preview-page-down",
      ["<C-q>"] = "select-all+accept",
    },
  },
  grep = {
    RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
    rg_glob = true,
    fzf_opts = {
      ["--history"] = vim.fn.expand("~/.local/share/nvim") .. "/" .. "fzf_grep_history",
    },
    no_header = true,
  },
})
require("fzf-lua").register_ui_select()

vim.keymap.set("n", "<D-b>", function() require("fzf-lua").buffers() end, { desc = "Buffers", silent = true })
vim.keymap.set({ "n", "x" }, "<D-i>", function() require("fzf-lua").blines() end, { desc = "Buffer lines", silent = true })
vim.keymap.set("n", "?", function() require("fzf-lua").helptags() end, { desc = "Help", silent = true })
vim.keymap.set("n", "<D-o>", function() require("fzf-lua").files() end, { desc = "Open file", silent = true })
vim.keymap.set("x", "<D-o>", function()
  local reg = vim.fn.getreg("v")
  vim.cmd('noau normal! "vy')
  local sel = vim.fn.getreg("v")
  vim.fn.setreg("v", reg)
  require("fzf-lua").files({ fzf_opts = { ["--query"] = sel } })
end, { desc = "Open file by selection", silent = true })
vim.keymap.set("n", "<D-f>", function() require("fzf-lua").grep_project() end, { desc = "Fuzzy grep", silent = true })
vim.keymap.set("n", "<D-g>", function() require("fzf-lua").live_grep() end, { desc = "Live grep", silent = true })
vim.keymap.set("x", "<D-f>", function() require("fzf-lua").grep_visual() end, { desc = "Search selection in project", silent = true })
