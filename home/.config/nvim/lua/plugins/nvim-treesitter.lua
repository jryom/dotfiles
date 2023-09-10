return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = "windwp/nvim-ts-autotag",
  build = ":TSUpdate",
  event = { "BufReadPost" },
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      autopairs = { enable = true },
      autotag = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "comment",
        "css",
        "diff",
        "dockerfile",
        "fish",
        "gitcommit",
        "gitignore",
        "help",
        "html",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "markdown",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      ignore_install = { "phpdoc", "ocaml" },
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = true, disable = "yaml" },
    })
  end,
}
