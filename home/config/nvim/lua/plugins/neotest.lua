---@type LazySpec
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  cmd = "Neotest",
  keys = {
    {
      "<space>tr",
      function() require("neotest").run.run() end,
      desc = "Run nearest test",
      silent = true,
    },
    {
      "<space>tw",
      function() require("neotest").watch.toggle() end,
      desc = "Watch mode toggle",
      silent = true,
    },
  },
  init = function() require("which-key").add({ "<space>t", group = "Test" }) end,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestConfigFile = "jest.config.js",
          env = { CI = true },
        }),
      },
      quickfix = {
        enabled = false,
        open = false,
      },
      output_panel = {
        enabled = true,
        open = "rightbelow vsplit | resize 30",
      },
      status = {
        enabled = true,
        virtual_text = false,
        signs = true,
      },
    })
  end,
}
