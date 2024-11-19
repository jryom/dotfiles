---@type LazySpec
return {
  {
    "folke/lazydev.nvim",
    version = "*",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "LazySpec" } },
      },
    },
  },
  { "bilal2453/luvit-meta", lazy = true },
}
