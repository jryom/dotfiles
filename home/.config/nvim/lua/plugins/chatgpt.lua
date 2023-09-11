return {
  "jackmort/chatgpt.nvim",
  cmd = { "ChatGPT", "ChatGPTEditWithInstruction", "ChatGPTRun" },
  config = function()
    require("chatgpt").setup()
  end,
  dependencies = {
    "muniftanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
