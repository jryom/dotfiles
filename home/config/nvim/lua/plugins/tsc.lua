---@type LazySpec
return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  config = function()
    require("tsc").setup({
      auto_open_qflist = true,
      use_trouble_qflist = true,
      enable_progress_notifications = true,
      enable_error_notifications = true,
      flags = { noEmit = true },
      hide_progress_notifications_from_history = true,
    })
  end,
}
