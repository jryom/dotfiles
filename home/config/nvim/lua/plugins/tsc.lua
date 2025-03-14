---@type LazySpec
return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  config = function()
    require("tsc").setup({
      auto_open_qflist = true,
      auto_start_watch_mode = false,
      enable_error_notifications = true,
      enable_progress_notifications = true,
      flags = { noEmit = true, watch = true },
      hide_progress_notifications_from_history = true,
      use_trouble_qflist = true,
    })
  end,
}
