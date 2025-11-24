return {
  "folke/which-key.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      preset = "helix",
      icons = { rules = false },
      spec = {
        -- Tabs
        { "<C-t>H", ":-tabmove<cr>", desc = "Move tab left" },
        { "<C-t>L", ":tabmove<cr>", desc = "Move tab right" },
        { "<C-t>c", ":tabclose<cr>", desc = "Close tab" },
        { "<C-t>h", ":tabprev<cr>", desc = "Previous tab" },
        { "<C-t>l", ":tabnext<cr>", desc = "Next tab" },
        { "<C-t>n", ":tab split<cr>", desc = "New tab" },
        -- Misc
        { "<space>L", function() require("lazy").home() end, desc = "Set fold level to 1" },
        { "z1", ":set foldlevel=1<cr>", desc = "Set fold level to 1" },
        { "<D-s>", ":silent w<cr>", desc = "Write file", silent = true },
        { "<esc>", ":nohlsearch<cr>", desc = "Disable search highlight" },
        {
          "<space>m",
          function()
            require("overseer").run_template({ name = "Markdown Preview" })
          end,
          desc = "Markdown preview",
        },
        { "<space>p", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
        { "<space>n", vim.diagnostic.goto_next, desc = "Next diagnostic" },
        { "gt", "<C-]>", desc = "Go to tag" },
        { "<", "<gv", desc = "Outdent", mode = { "x" } },
        { ">", ">gv", desc = "Indent", mode = { "x" } },
        {
          "<leader>cp",
          function()
            local path = vim.fn.expand("%:~:.")
            if path ~= "" then vim.fn.setreg("+", path) end
          end,
          desc = "Copy relative file path",
        },
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
            local command =
              vim.api.nvim_replace_termcodes('"py:%sno///<left><left><c-r>p<right><c-r>p', false, false, true)
            vim.api.nvim_feedkeys(command, "n", true)
          end,
          desc = "Replace visual selection",
          mode = "x",
        },
      },
    })
  end,
}
