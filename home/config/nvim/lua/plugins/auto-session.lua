return {
  "rmagatti/auto-session",
  config = function()
    require("which-key").add({
      { "<space>S", group = "Session" },
      { "<space>Sc", ":lua require('auto-session').SaveSession()<cr>", desc = "Create" },
      { "<space>Sd", ":lua require('auto-session').DeleteSession()<cr>", desc = "Delete" },
    })
    require("auto-session").setup({
      auto_create = true,
      auto_restore = true,
      auto_save = true,
      lazy_support = true,
      log_level = "error",
      use_git_branch = true,
    })
  end,
}
