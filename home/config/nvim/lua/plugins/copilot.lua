return {
  "zbirenbaum/copilot.lua",
  version = "*",
  event = { "InsertEnter" },
  cmd = { "Copilot" },
  keys = {
    {
      "<Tab>",
      function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end,
      mode = { "i" },
    },
    { "yop", "<cmd>Copilot disable<cr>", desc = "Toggle Copilot" },
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
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        trigger_on_accept = true,
        keymap = {
          accept_word = false,
          accept_line = false,
          next = "<Right>",
          prev = "<Left>",
          dismiss = "<C-c>",
        },
      },
    })
  end,
}
