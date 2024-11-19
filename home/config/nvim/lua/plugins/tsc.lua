---@type LazySpec
return {
  "dmmulroy/tsc.nvim",
  version = "*",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("tsc").setup({
      use_trouble_qflist = true,
      use_diagnostics = true,
      enable_progress_notifications = false,
      flags = {
        watch = true,
      },
    })
  end,
}
