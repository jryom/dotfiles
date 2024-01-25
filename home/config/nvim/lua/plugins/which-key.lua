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

      gt = { "<C-]>", "Go to tag" },
      j = { "v:count == 0 ? 'gj' : '<Esc>'.v:count.'j'", "Next visual line", expr = true },
      k = { "v:count == 0 ? 'gk' : '<Esc>'.v:count.'k'", "Previous visual line", expr = true },
      ["<esc>"] = { ":nohlsearch<cr>", "Disable search highlight" },
      [">"] = { ">gv", "Indent", mode = "x" },
      ["<"] = { "<gv", "Outdent", mode = "x" },
      ["<space>L"] = { ":Lazy<cr>", "Lazy" },
      ["<space>m"] = { ":!(gh markdown-preview % &); sleep 5; kill $\\!<cr>", "Markdown preview", silent = true },
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
