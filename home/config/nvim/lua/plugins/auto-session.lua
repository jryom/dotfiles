---@type LazySpec
return {
  "rmagatti/auto-session",
  config = function()
    require("which-key").add({
      { "<space>S", group = "Session" },
      { "<space>Sc", ":lua require('auto-session').SaveSession()<cr>", desc = "Create" },
      { "<space>Sd", ":lua require('auto-session').DeleteSession()<cr>", desc = "Delete" },
    })
    require("auto-session").setup({
      auto_restore_enabled = true,
      auto_save_enabled = true,
      log_level = "error",
    })
  end,
}
