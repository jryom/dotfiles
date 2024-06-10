return {
  {
    "copilotc-nvim/copilotchat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      local group = vim.api.nvim_create_augroup("copilot", {})
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = { "copilot-chat" },
        command = "vertical resize 80",
        group = group,
      })
    end,
    opts = {
      auto_insert_mode = true,
      show_folds = false,
    },
    keys = {
      { "<leader>ac", "<cmd>CopilotChat<cr>", mode = { "x", "n" }, desc = "Open in vertical split" },
      { "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Refactor code", mode = { "n", "x" } },
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code", mode = { "n", "x" } },
      { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
      { "<leader>ag", "<cmd>CopilotChatCommitStaged<cr>", desc = "Generate commit message for staged changes" },
      { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming", mode = { "n", "x" } },
      { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Refactor code", mode = { "n", "x" } },
      { "<leader>ar", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code", mode = { "n", "x" } },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests", mode = { "n", "x" } },
    },
  },
}
