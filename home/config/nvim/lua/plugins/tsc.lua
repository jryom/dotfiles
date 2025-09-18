return {
  "dmmulroy/tsc.nvim",
  ft = { "typescript", "typescriptreact" },
  keys = {
    { "<leader>T", "<cmd>TSC<cr>", desc = "TSC" },
    { "<leader>TR", "<cmd>TSCWatch<cr>", desc = "TSC Watch" },
  },
  config = function()
    require("tsc").setup({
      auto_open_qflist = true,
      auto_start_watch_mode = false,
      bin_path = vim.fn.trim(vim.fn.system("which tsgo")),
      --- @diagnostic disable-next-line: assign-type-mismatch
      flags = "--noEmit true --pretty false",
      hide_progress_notifications_from_history = true,
      use_trouble_qflist = true,
    })
  end,
}
