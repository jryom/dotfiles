return {
  { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
  { "hrsh7th/cmp-path", after = "nvim-cmp" },
  { "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
  { "hrsh7th/vim-vsnip", after = "nvim-cmp" },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<C-l>"] = cmp.mapping.confirm({
            select = true,
          }),
        },
        sources = {
          { name = "path" },
          { name = "vsnip" },
          { name = "nvim_lsp" },
          { name = "buffer" },
        },
      })
    end,
  },
}
