---@type LazySpec
return {
  "lukas-reineke/indent-blankline.nvim",
  version = "*",
  event = "VeryLazy",
  main = "ibl",
  config = function()
    require("ibl").setup({
      scope = { enabled = false },
    })
  end,
}
