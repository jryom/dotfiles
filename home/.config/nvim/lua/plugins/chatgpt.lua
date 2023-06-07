return {
  "jackmort/chatgpt.nvim",
  cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTCompleteCode" },
  config = function()
    require("chatgpt").setup()
  end,
  dependencies = {
    "muniftanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
