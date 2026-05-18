vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })

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

vim.keymap.set("i", "<Tab>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end)

vim.keymap.set("n", "yop", "<cmd>Copilot disable<cr>", { desc = "Toggle Copilot" })
