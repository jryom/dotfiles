---@type LazySpec
return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ibhagwan/fzf-lua",
  },
  cmd = {
    "Octo",
  },
  config = function()
    require("octo").setup({
      picker = "fzf-lua",
      file_panel = {
        use_icons = false,
      },
    })
  end,
}
