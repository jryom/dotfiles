function _G.getLualineOpts(isDarkMode)
  return {
    options = {
      theme = isDarkMode and "zenflesh" or "zenbones",
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_x = { "filetype" },
      lualine_y = {
        {
          "diagnostics",
          sources = { "nvim_lsp" },
          symbols = { error = "E: ", warn = "W: ", info = "I: ", hint = "H: " },
          sections = { "error", "warn" },
        },
      },
      lualine_z = { "location" },
    },
  }
end

return {
  {
    "mcchrish/zenbones.nvim",
    config = function()
      local isDarkMode = string.match(vim.fn.system("defaults read -g AppleInterfaceStyle"), "Dark")
        == "Dark"
      vim.g.zenbones_dim_noncurrent_window = true
      vim.g.zenflesh_darkness = "warm"
      vim.g.zenflesh_lighten_noncurrent_window = true
      vim.cmd(isDarkMode and "colo zenflesh-lush" or "color zenbones-lush")
    end,
  },
  
  {
    "cormacrelf/dark-notify",
    event = "CursorHold",
    config = function()
      require("dark_notify").run({
        onchange = function(mode)
          if vim.g.colors_name == nil then
            vim.cmd(mode == "dark" and "colo zenflesh-lush" or "color zenbones-lush")
            require("plenary.reload").reload_module("lualine", true)
            require("lualine").setup(getLualineOpts(mode))
          end
        end,
      })
    end,
  },

  {
    "hoob3rt/lualine.nvim",
    config = function()
      require("lualine").setup(
        getLualineOpts(
          string.match(vim.fn.system("defaults read -g AppleInterfaceStyle"), "Dark") == "Dark"
        )
      )
    end,
  },
}