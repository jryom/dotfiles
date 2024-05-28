return {
  "copilotc-nvim/copilotchat.nvim",
  branch = "canary",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim" },
  },
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
  keys = {
    {
      "<space>ac",
      ":CopilotChatToggle<CR>",
      desc = "Copilot Chat",
      silent = true,
    },
  },
}
