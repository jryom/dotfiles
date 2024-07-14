---@type LazySpec
return {
  "stevearc/dressing.nvim",
  config = function()
    require("dressing").setup({
      select = {
        enabled = true,
        backend = { "builtin" },
        builtin = {
          border = "rounded",
          relative = "cursor",
          min_width = { 1, 0 },
          min_height = { 1, 0 },
          mappings = {
            ["q"] = "Close",
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
        },
      },
    })
  end,
}
