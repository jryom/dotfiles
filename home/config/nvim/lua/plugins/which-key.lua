return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    show_help = false,
    show_keys = false,
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local map = require("which-key").register

    map({
      -- Prefixes
      { "<space>", { name = "Git" } },
      { ["<space>a"] = { name = "AI" } },
      { ["<space>g"] = { name = "Generate annotation" } },

      ["<space>r"] = {
        function()
          local command =
            vim.api.nvim_replace_termcodes('"py:%s///g<left><left><left><c-r>p<right>', false, false, true)
          vim.api.nvim_feedkeys(command, "n", {})
        end,
        "Replace visual selection",
        mode = "x",
      },
      gt = { "<C-]>", "Go to tag" },
      ["<esc>"] = { ":nohlsearch<cr>", "Disable search highlight" },
      [">"] = { { ">gv", "Indent", mode = "x" }, { ">>", "Indent", mode = "n" } },
      ["<"] = { { "<gv", "Outdent", mode = "x" }, { "<<", "Outdent", mode = "n" } },
      ["<space>L"] = { ":Lazy<cr>", "Lazy" },
      ["<space>"] = {
        p = { vim.diagnostic.goto_prev, "Previous diagnostic" },
        n = { vim.diagnostic.goto_next, "Next diagnostic" },
      },
      ["<C-k>"] = {
        {
          function()
            vim.cmd.normal("zc")
          end,
          "Close fold",
          mode = "n",
        },
        {
          function()
            vim.cmd.normal("zc")
          end,
          "Close fold",
          mode = "x",
        },
      },
      ["<C-j>"] = {
        {
          function()
            vim.cmd.normal("zo")
          end,
          "Open fold",
          mode = "n",
        },
        {
          function()
            vim.cmd.normal("zo")
          end,
          "Open fold",
          mode = "x",
        },
      },
      ["<C-t>"] = {
        h = { ":tabprev<cr>", "Previous tab" },
        l = { ":tabnext<cr>", "Next tab" },
        n = { ":tabnew<cr>", "New tab" },
        c = { ":tabclose<cr>", "Close tab" },
        H = { ":-tabmove<cr>", "Move tab left" },
        L = { ":tabmove<cr>", "Move tab right" },
        s = { ":tab split<cr>", "Tab split" },
      },
    })
  end,
}
