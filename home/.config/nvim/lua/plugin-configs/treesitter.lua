return function()
  require("nvim-treesitter.configs").setup({
    autopairs = { enable = true },
    autotag = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
    },
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
    highlight = { enable = true },
    indent = { enable = true },
  })
end
