return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = "windwp/nvim-ts-autotag",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      autotag = { enable = true },
      ensure_installed = { "lua", "bash", "markdown", "markdown_inline", "regex" },
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
      indent = { disable = "yaml" },
      matchup = { enable = true },
    })
  end,
}
