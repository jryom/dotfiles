---@type LazySpec
return {
  "copilotc-nvim/copilotchat.nvim",
  version = "*",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
  },
  event = { "InsertEnter" },
  cmd = { "Copilot", "CopilotChat" },
  build = "make tiktoken",
  keys = {
    { "<leader>ac", "<cmd>CopilotChat<cr>", mode = { "x", "n" }, desc = "Open in vertical split" },
    { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Write docs", mode = { "n", "x" } },
    { "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix diagnostic", mode = { "n", "x" } },
    { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize", mode = { "n", "x" } },
    { "<leader>aR", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
    { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review", mode = { "n", "x" } },
    { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests", mode = { "n", "x" } },
    { "yop", function() vim.b.copilot_enabled = not vim.b.copilot_enabled end, desc = "Toggle Copilot" },
  },
  init = function() require("which-key").add({ "<leader>a", group = "AI" }) end,
  config = function()
    require("copilot").setup({
      filetypes = {
        gitcommit = true,
        markdown = true,
        yaml = true,
      },
      suggestion = {
        auto_trigger = true,
        hide_during_completion = true,
        trigger_on_accept = true,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<Right>",
          prev = "<Left>",
          dismiss = "<C-c>",
        },
      },
    })

    local group = vim.api.nvim_create_augroup("copilot", {})
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = { "copilot-chat" },
      command = "vertical resize 80",
      group = group,
    })

    require("CopilotChat").setup({
      mappings = { complete = { insert = "" } },
      context = "buffers",
      model = "claude-3.7-sonnet-thought",
    })
  end,
}
