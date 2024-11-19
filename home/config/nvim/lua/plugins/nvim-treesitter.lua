---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = { "lua", "bash", "markdown", "markdown_inline", "regex" },
      highlight = { enable = true },
      ignore_install = {},
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<Tab>",
          scope_incremental = "<CR>",
          node_decremental = "<S-Tab>",
        },
      },
      indent = { disable = "yaml" },
      matchup = { enable = true },
      modules = {},
      sync_install = false,
    })
  end,
}
