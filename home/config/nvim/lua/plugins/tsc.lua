---@type LazySpec
return {
  "dmmulroy/tsc.nvim",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("tsc").setup({
      auto_start_watch_mode = true,
      auto_open_qflist = false,
      use_trouble_qflist = true,
      use_diagnostics = true,
      enable_progress_notifications = false,
      flags = {
        watch = true,
      },
    })
  end,
}
