return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      autopairs = { enable = true },
      autotag = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
      },
      ensure_installed = "maintained",
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
