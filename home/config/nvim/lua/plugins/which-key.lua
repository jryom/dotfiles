---@type LazySpec
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      preset = "helix",
      show_help = false,
      show_keys = false,
      icons = { rules = false },
      plugins = {
        marks = false,
      },
      spec = {
        -- Tabs
        { "<C-t>H", ":-tabmove<cr>", desc = "Move tab left" },
        { "<C-t>L", ":tabmove<cr>", desc = "Move tab right" },
        { "<C-t>c", ":tabclose<cr>", desc = "Close tab" },
        { "<C-t>h", ":tabprev<cr>", desc = "Previous tab" },
        { "<C-t>l", ":tabnext<cr>", desc = "Next tab" },
        { "<C-t>n", ":tabnew<cr>", desc = "New tab" },
        { "<C-t>s", ":tab split<cr>", desc = "Tab split" },
        -- Misc
        { "<D-s>", ":w<cr>", desc = "Write file" },
        { "<esc>", ":nohlsearch<cr>", desc = "Disable search highlight" },
        { "<space>L", ":Lazy<cr>", desc = "Lazy" },
        { "<space>m", ":!timeout 3s gh markdown-preview %<cr>", desc = "Markdown preview" },
        { "<space>p", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
        { "<space>n", vim.diagnostic.goto_next, desc = "Next diagnostic" },
        { "gt", "<C-]>", desc = "Go to tag" },
        { "<", "<gv", desc = "Outdent", mode = { "x" } },
        { ">", ">gv", desc = "Indent", mode = { "x" } },
        {
          "<C-j>",
          function() vim.cmd("norm! zo") end,
          desc = "Open fold",
        },
        {
          "<C-k>",
          function() vim.cmd("norm! zc") end,
          desc = "Close fold",
        },
        {
          "<space>r",
          function()
            local command = vim.api.nvim_replace_termcodes('"py:%sno///<left><left><c-r>p<right>', false, false, true)
            vim.api.nvim_feedkeys(command, "n", true)
          end,
          desc = "Replace visual selection",
          mode = "x",
        },
      },
    })
  end,
}
