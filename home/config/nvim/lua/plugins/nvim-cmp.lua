local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "b0o/schemastore.nvim",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      local cmp = require("cmp")

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      return {
        window = { completion = { col_offset = -3, side_padding = 0 } },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "nvim_lua" },
          { name = "path" },
        }, {
          { name = "buffer", keyword_length = 2, max_item_count = 10 },
        }),
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-l>"] = cmp.mapping(function()
            if vim.fn["vsnip#available"](1) and not cmp.visible() then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            else
              cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
            end
          end, { "i", "c" }),

          ["<C-p>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            else
              fallback()
            end
          end, { "i" }),

          ["<C-n>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            else
              fallback()
            end
          end, { "i" }),

          ["<C-j>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end, { "i", "c" }),

          ["<C-k>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
            end
          end, { "i", "c" }),
        },
      }
    end,
  },
}
