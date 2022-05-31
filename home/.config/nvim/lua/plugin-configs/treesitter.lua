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
    ignore_install = { "phpdoc", "ocaml" },
    highlight = { enable = true },
    indent = { enable = true, disable = "yaml" },
  })
end
