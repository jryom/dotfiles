return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerInfo" },
  keys = {
    { "<space>oo", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
    { "<space>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
  },
  opts = {
    task_list = {
      bindings = {
        ["<C-l>"] = false,
        ["<C-h>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
      },
    },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    -- Register markdown preview task template
    overseer.register_template({
      name = "Markdown Preview",
      builder = function()
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "gh", "markdown-preview", file },
          components = {
            { "on_output_quickfix", open = false },
            "default",
          },
        }
      end,
      condition = {
        filetype = { "markdown" },
      },
    })
  end,
}
